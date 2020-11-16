#!/usr/bin/env python3
import random
import torch
import math
import numpy as np
from torch.utils.tensorboard import SummaryWriter
from collections import deque, namedtuple
import time
import gym
from naf.DQN import DQN_Agent
import argparse
import wandb
import rospy
import rospkg
from mybaxter_env import BaxterEnv
wandb.init(project="naf")

def run(agent, max_episode=5000, save_freq=100):
    """"NAF.
    
    Params
    ======

    """
    scores = []                        # list containing scores from each episode
    scores_window = deque(maxlen=100)  # last 100 scores
    frame = 0
    i_episode = 0
    state = env.reset()
    score = 0
    mean_100_rew = 0
    best_rew = -np.inf
    agent.qnetwork_local.load_state_dict(torch.load("NAF_Baxter_2.pth"))                  
    while i_episode < max_episode:

        action = agent.act(state)

        next_state, reward, done, _ = env.step(action)
        agent.step(state, action, reward, next_state, done)

        state = next_state
        score += reward

        if done:
            scores_window.append(score)       # save most recent score
            scores.append(score)              # save most recent score
            mean_100_rew = np.mean(scores_window)
            wandb.log({"Reward": score, "Average100": mean_100_rew, "Step": frame})

            print('\rEpisode {}\tFrame {} \tAverage Score: {:.2f}'.format(i_episode, frame, mean_100_rew), end="")
            if i_episode % 100 == 0:
                print('\rEpisode {}\tFrame {}\tAverage Score: {:.2f}'.format(i_episode,frame, mean_100_rew))
            i_episode +=1 
            state = env.reset()
            score = 0


            if mean_100_rew > best_rew:
                torch.save(agent.qnetwork_local.state_dict(), "NAF_Baxter_2.pth")
                print(f"\nBest model saved at episode {i_episode} with mean_100_rew {mean_100_rew}\n")
                best_rew = mean_100_rew

        frame += 1


    return np.mean(scores_window)


if __name__ == "__main__":
    rospy.init_node('baxter_naf_gym', anonymous=True)
    parser = argparse.ArgumentParser()

    parser.add_argument('-env', type=str, default="BaxterGym-v0",
                     help='Name of the environment (default: Pendulum-v0)')
    parser.add_argument('-e', "--max_episode", type=int, default=5000,
                     help='Number of Episodes to run for(default: 5000)') 
    parser.add_argument('-f', "--frames", type=int, default=65000,
                     help='Number of training frames (default: 40000)')    
    parser.add_argument('-mem', type=int, default=100000,
                     help='Replay buffer size (default: 100000)')
    parser.add_argument('-per', type=int, choices=[0,1],  default=0,
                     help='Use prioritized experience replay (default: False)')
    parser.add_argument('-b', "--batch_size", type=int, default=128,
                     help='Batch size (default: 128)')
    parser.add_argument('-nstep', type=int, default=1,
                     help='nstep_bootstrapping (default: 1)')
    parser.add_argument('-l', "--layer_size", type=int, default=150,
                     help='Neural Network layer size (default: 150)')
    parser.add_argument('-g', "--gamma", type=float, default=0.99,
                     help='Discount factor gamma (default: 0.99)')
    parser.add_argument('-t', "--tau", type=float, default=1e-3,
                     help='Soft update factor tau (default: 1e-2)')
    parser.add_argument('-lr', "--learning_rate", type=float, default=1e-3,
                     help='Learning rate (default: 1e-3)')
    parser.add_argument('-u', "--update_every", type=int, default=1,
                     help='update the network every x step (default: 1)')
    parser.add_argument('-n_up', "--n_updates", type=int, default=3 ,
                     help='update the network for x steps (default: 3)')
    parser.add_argument('-s', "--seed", type=int, default=0,
                     help='random seed (default: 0)')

    args = parser.parse_args()

    wandb.config.update(args)

    seed = args.seed
    BUFFER_SIZE = args.mem
    per = args.per
    BATCH_SIZE = args.batch_size
    LAYER_SIZE = args.layer_size
    nstep = args.nstep
    GAMMA = args.gamma
    TAU = args.tau
    LR = args.learning_rate
    UPDATE_EVERY = args.update_every
    NUPDATES = args.n_updates
    MAX_EPISODE = args.max_episode

    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    print("Using ", device)

    np.random.seed(seed)
    env = gym.make(args.env) 


    env.seed(seed)
    action_size     = env.action_space.shape[0]
    state_size = env.observation_space.shape[0]

    agent = DQN_Agent(state_size=state_size,    
                        action_size=action_size,
                        layer_size=LAYER_SIZE,
                        BATCH_SIZE=BATCH_SIZE, 
                        BUFFER_SIZE=BUFFER_SIZE,
                        PER=per, 
                        LR=LR,
                        Nstep=nstep, 
                        TAU=TAU, 
                        GAMMA=GAMMA, 
                        UPDATE_EVERY=UPDATE_EVERY,
                        NUPDATES=NUPDATES,
                        device=device, 
                        seed=seed)



    t0 = time.time()
    final_average100 = run(max_episode=MAX_EPISODE, agent=agent)
    t1 = time.time()
    
    print("Training time: {}min".format(round((t1-t0)/60,2)))
    torch.save(agent.qnetwork_local.state_dict(), "NAF_"+args.env+"_2.pth")