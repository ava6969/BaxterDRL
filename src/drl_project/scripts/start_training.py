#!/usr/bin/env python3

'''
    Training code made by Ricardo Tellez <rtellez@theconstructsim.com>
    Based on many other examples around Internet
    Visit our website at www.theconstruct.ai
'''
import gym
import time
import numpy as np
import random
import time
from stable_baselines3 import DDPG, PPO, SAC
from gym import wrappers
import torch as th
from stable_baselines3.common.evaluation import evaluate_policy

from stable_baselines3 import TD3
from stable_baselines3.common.monitor import Monitor
from stable_baselines3.common.results_plotter import load_results, ts2xy
from stable_baselines3.common.noise import NormalActionNoise
from stable_baselines3.common.callbacks import BaseCallback
import os
# ROS packages required
import rospy
import rospkg

# import our training environment
from mybaxter_env import BaxterEnv
from pnp_baxter_env import PnPBaxterEnv
from stable_baselines3.common.env_checker import check_env
class SaveOnBestTrainingRewardCallback(BaseCallback):
    """
    Callback for saving a model (the check is done every ``check_freq`` steps)
    based on the training reward (in practice, we recommend using ``EvalCallback``).

    :param check_freq: (int)
    :param log_dir: (str) Path to the folder where the model will be saved.
      It must contains the file created by the ``Monitor`` wrapper.
    :param verbose: (int)
    """
    def __init__(self, check_freq: int, log_dir: str, verbose=1):
        super(SaveOnBestTrainingRewardCallback, self).__init__(verbose)
        self.check_freq = check_freq
        self.log_dir = log_dir
        self.save_path = os.path.join(log_dir, 'best_model')
        self.best_mean_reward = -np.inf
   

    def _init_callback(self) -> None:
        # Create folder if needed
        if self.save_path is not None:
            os.makedirs(self.save_path, exist_ok=True)

    def _on_step(self) -> bool:
        if self.n_calls % self.check_freq == 0:

          # Retrieve training reward
          x, y = ts2xy(load_results(self.log_dir), 'timesteps')
          if len(x) > 0:
              # Mean training reward over the last 100 episodes
              mean_reward = np.mean(y[-100:])
              if self.verbose > 0:
                print(f"Num timesteps: {self.num_timesteps}")
                print(f"Best mean reward: {self.best_mean_reward:.2f} - Last mean reward per episode: {mean_reward:.2f}")

              # New best model, you could save the agent here
              if mean_reward > self.best_mean_reward:
                  self.best_mean_reward = mean_reward
                  # Example for saving best model
                  if self.verbose > 0:
                    print(f"Saving new best model to {self.save_path}.zip")
                  self.model.save(self.save_path)

        return True

if __name__ == '__main__':
    rospy.init_node('baxter_gym', anonymous=True)
    # Create the Gym environment
    # env = gym.make('BaxterGym-v0')
    env = gym.make('PnPBaxter-v0')
    rospy.loginfo ( "Gym environment done")
    # Create log dir
    log_dir = "./log/gym/"
    os.makedirs(log_dir, exist_ok=True)

    # Logs will be saved in log_dir/monitor.csv
    env = Monitor(env, log_dir)
    # Create action noise because TD3 and DDPG use a deterministic policy
    #n_actions = env.action_space.shape[-1]
    #action_noise = NormalActionNoise(mean=np.zeros(n_actions), sigma=0.1 * np.ones(n_actions))
    # Create the callback: check every 1000 steps
    callback = SaveOnBestTrainingRewardCallback(check_freq=1000, log_dir=log_dir)

    # Custom MLP policy of two layers of size 100 each with tanh activation function
    policy_kwargs = dict(net_arch=dict(pi=[400, 300], qf=[400, 300]), activation_fn=th.nn.Tanh)
    model = DDPG('MlpPolicy', env, batch_size=128, policy_kwargs=policy_kwargs,verbose=1,tensorboard_log="./log/tensor_board/")
  
    #model = DDPG.load("/home/dewe/Documents/DDPGReacher/gym/best_model",env)
    #print("loaded model")

    model.learn(total_timesteps=1000000, callback=callback)

    # Evaluate the agent
    mean_reward, std_reward = evaluate_policy(model, model.get_env(), n_eval_episodes=100)
    print(f"Eval mean_reward={mean_reward:.2f} +/- {std_reward}")

    model.save("DDPG-baxter")

    env.close()