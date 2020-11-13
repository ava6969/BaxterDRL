#!/usr/bin/env python3
import random
from naf.naf_model import NAF
from naf.ou_noise import OUNoise
from naf.replay_buffer import ReplayBuffer
import numpy as np
import torch
import torch.nn.functional as F
import torch.optim as optim
from torch.nn.utils import clip_grad_norm_
import wandb
from naf.PER import PrioritizedReplay
wandb.init(project="naf")

class DQN_Agent():
    """Interacts with and learns from the environment."""

    def __init__(self,
                 state_size,
                 action_size,
                 layer_size,
                 BATCH_SIZE,
                 BUFFER_SIZE,
                 PER,
                 LR,
                 Nstep,
                 TAU,
                 GAMMA,
                 UPDATE_EVERY,
                 NUPDATES,
                 device,
                 seed):
        """Initialize an Agent object.
        
        Params
        ======
            state_size (int): dimension of each state
            action_size (int): dimension of each action
            Network (str): dqn network type
            layer_size (int): size of the hidden layer
            BATCH_SIZE (int): size of the training batch
            BUFFER_SIZE (int): size of the replay memory
            LR (float): learning rate
            TAU (float): tau for soft updating the network weights
            GAMMA (float): discount factor
            UPDATE_EVERY (int): update frequency
            device (str): device that is used for the compute
            seed (int): random seed
        """
        self.state_size = state_size
        self.action_size = action_size
        self.seed = random.seed(seed)
        self.device = device
        self.TAU = TAU
        self.GAMMA = GAMMA
        self.nstep = Nstep
        self.UPDATE_EVERY = UPDATE_EVERY
        self.NUPDATES = NUPDATES
        self.BATCH_SIZE = BATCH_SIZE
        self.Q_updates = 0
        self.per = PER

        self.action_step = 4
        self.last_action = None

        # Q-Network
        self.qnetwork_local = NAF(state_size, action_size,layer_size, seed).to(device)
        self.qnetwork_target = NAF(state_size, action_size,layer_size, seed).to(device)
        wandb.watch(self.qnetwork_local)
        self.optimizer = optim.Adam(self.qnetwork_local.parameters(), lr=LR)
        print(self.qnetwork_local)
        
        # Replay memory
        if PER == True:
            print("Using Prioritized Experience Replay")
            self.memory = PrioritizedReplay(BUFFER_SIZE, BATCH_SIZE, seed, n_step=self.nstep)
        else:
            print("Using Regular Experience Replay")
            self.memory = ReplayBuffer(BUFFER_SIZE, BATCH_SIZE, self.device, seed, self.GAMMA, self.nstep)
        
        # Initialize time step (for updating every UPDATE_EVERY steps)
        self.t_step = 0 
    
    def step(self, state, action, reward, next_state, done):
        # Save experience in replay memory
        self.memory.add(state, action, reward, next_state, done)
        
        # Learn every UPDATE_EVERY time steps.
        self.t_step = (self.t_step + 1) % self.UPDATE_EVERY
        if self.t_step == 0:
            # If enough samples are available in memory, get random subset and learn
            if len(self.memory) > self.BATCH_SIZE:
                Q_losses = []
                for _ in range(self.NUPDATES):
                    experiences = self.memory.sample()
                    if self.per == True:
                        loss = self.learn_per(experiences)
                    else:
                        loss = self.learn(experiences)
                    self.Q_updates += 1
                    Q_losses.append(loss)
                #wandb.log({"Q_loss": np.mean(Q_losses), "Optimization step": self.Q_updates})


    def act(self, state):
        """Calculating the action
        
        Params
        ======
            state (array_like): current state
            
        """

        state = torch.from_numpy(state).float().to(self.device)

        self.qnetwork_local.eval()
        with torch.no_grad():
            action, _, _ = self.qnetwork_local(state.unsqueeze(0))
            #action = action.cpu().squeeze().numpy() + self.noise.sample()
            #action = np.clip(action, -1,1)[0]
        self.qnetwork_local.train()
        return action.cpu().squeeze().numpy().reshape((self.action_size,))



    def learn(self, experiences):
        """Update value parameters using given batch of experience tuples.
        Params
        ======
            experiences (Tuple[torch.Tensor]): tuple of (s, a, r, s', done) tuples 
        """
        self.optimizer.zero_grad()
        states, actions, rewards, next_states, dones = experiences

        # get the Value for the next state from target model
        with torch.no_grad():
            _, _, V_ = self.qnetwork_target(next_states)

        # Compute Q targets for current states 
        V_targets = rewards + (self.GAMMA**self.nstep * V_ * (1 - dones))
        
        # Get expected Q values from local model
        _, Q, _ = self.qnetwork_local(states, actions)

        # Compute loss
        loss = F.mse_loss(Q, V_targets)
        
        # Minimize the loss
        loss.backward()
        clip_grad_norm_(self.qnetwork_local.parameters(),1)
        self.optimizer.step()

        # ------------------- update target network ------------------- #
        self.soft_update(self.qnetwork_local, self.qnetwork_target)
        

        
        return loss.detach().cpu().numpy()

    def learn_per(self, experiences):
        """Update value parameters using given batch of experience tuples.
        Params
        ======
            experiences (Tuple[torch.Tensor]): tuple of (s, a, r, s', done) tuples 
        """
        self.optimizer.zero_grad()
        states, actions, rewards, next_states, dones, idx, weights = experiences

        states = torch.FloatTensor(states).to(self.device)
        next_states = torch.FloatTensor(np.float32(next_states)).to(self.device)
        actions = torch.LongTensor(actions).to(self.device)
        rewards = torch.FloatTensor(rewards).to(self.device).unsqueeze(1) 
        dones = torch.FloatTensor(dones).to(self.device).unsqueeze(1)
        weights = torch.FloatTensor(weights).unsqueeze(1).to(self.device)
        
        # get the Value for the next state from target model
        with torch.no_grad():
            _, _, V_ = self.qnetwork_target(next_states)

        # Compute Q targets for current states 
        V_targets = rewards + (self.GAMMA**self.nstep * V_ * (1 - dones))
        
        # Get expected Q values from local model
        _, Q, _ = self.qnetwork_local(states, actions)

        # Compute loss
        td_error = V_targets - Q
        loss = (td_error.pow(2)*weights).mean().to(self.device)
        # Minimize the loss
        loss.backward()
        clip_grad_norm_(self.qnetwork_local.parameters(),1)
        self.optimizer.step()

        # ------------------- update target network ------------------- #
        self.soft_update(self.qnetwork_local, self.qnetwork_target)
        # update per priorities
        self.memory.update_priorities(idx, abs(td_error.data.cpu().numpy()))

        
        return loss.detach().cpu().numpy()       

    def soft_update(self, local_model, target_model):
        """Soft update model parameters.
        θ_target = τ*θ_local + (1 - τ)*θ_target
        Params
        ======
            local_model (PyTorch model): weights will be copied from
            target_model (PyTorch model): weights will be copied to
            tau (float): interpolation parameter 
        """
        for target_param, local_param in zip(target_model.parameters(), local_model.parameters()):
            target_param.data.copy_(self.TAU*local_param.data + (1.0-self.TAU)*target_param.data)
