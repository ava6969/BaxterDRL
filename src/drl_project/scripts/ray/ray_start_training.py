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
from gym import wrappers
import torch as th
from ray.tune.registry import register_env
import os
from ray.rllib.agents import ppo, ddpg
from ray.rllib.agents.ddpg import DDPGTrainer
# ROS packages required
import rospy
import rospkg

# import our training environment
from raybaxter_env import BaxterEnv
from ray import tune
def env_creator(env_config):
  return BaxterEnv(env_config)


if __name__ == '__main__':

    rospy.init_node('baxter_gym', anonymous=True)
    # Create the Gym environment
    register_env("BaxterGymEnv", env_creator)
    rospy.loginfo ( "Gym environment done")
    # Create log dir
    log_dir = "./log/gym/"
    os.makedirs(log_dir, exist_ok=True)
    # Custom MLP policy of two layers of size 100 each with tanh activation function
    policy_kwargs = dict(activation_fn=th.nn.Tanh, net_arch=[400, 300])
    #model = DDPG('MlpPolicy', env, batch_size=128, policy_kwargs=policy_kwargs, verbose=1,tensorboard_log="./log/tensor_board/")
    tune.run(PPOTrainer, config={"env": "BaxterGymEnv"}) 
