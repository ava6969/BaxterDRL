#!/usr/bin/env python3

import os
import copy
import numpy as np
import gym
from gym import error, spaces
from gym.utils import seeding
import rospy
import math
from gazebo_connection import GazeboConnection

def goal_distance(goal_a, goal_b):
    assert goal_a.shape == goal_b.shape
    return np.linalg.norm(goal_a - goal_b, axis=-1)

class BaxterGym(gym.GoalEnv):

    def __init__(self):
        self.seed()
        self.goal = self._sample_goal() # initial sample goal

        # hyperparams
        self.c_a = 10e-3 # regularization term
        self.u_bound_goal = 0.2 # sampled uniformaly and added to goal position 
        self.height_offset = 0.0 # height above table

        # assuming all joints have maz torques
        # add obj info for next experiment
        # put max torque and min torque, create different spaces for tehm,
        self.max_torque, self.min_torque = 50, -50
        self.max_joint_pos, self.min_joint_pos = 3.059, -3.059
        self.max_joint_vel, self.min_joint_vel = 4, -4
        self.max_valid_pos_x, self.min_valid_pos_x = 0.80, 0.40
        self.max_valid_pos_y, self.min_valid_pos_y = 0.5, 0.2

        # constraints
        constraints = {"left_s0" : (-1.70167993878, 1.70167993878, 1.5, 50),
                        "left_s1" : (-2.147, 1.047, 1.5, 50),
                        "left_e0" : (-3.05417993878, 3.05417993878, 1.5, 50),
                        "left_e1" : (-0.05, 2.618, 1.5, 50),
                        "left_w0" : (-3.059, 3.059, 4.0, 15),
                        "left_w1" : (-1.57079632679, 2.094, 4.0, 15),
                        "left_w2" : (-3.059, 3.059, 4.0, 15)}


      
        
        # valid x and y goals
        torque_space = spaces.Box(self.max_torque, self.min_torque,
                                         shape=(7, ), dtype='float32') # adjust later for range

        gripper_space = spaces.Box(0, 1, (1,))

        self.action_range = spaces.Tuple((torque_space, gripper_space))

        joint_pos_space = spaces.Box(self.min_joint_pos, self.max_joint_pos, shape=(7, ), dtype='float32')
        joint_vel_space = spaces.Box(self.min_joint_vel, self.max_joint_vel, shape=(7, ), dtype='float32')
        self.goal_space = spaces.Box([self.min_valid_pos_x, self.min_valid_pos_y], [self.max_valid_pos_x, self.max_valid_pos_y], 
                                        shape=(1, 1), dtype='float32')
        ee_space = spaces.Box(0, 1, (1,))
        self.observation_space = spaces.Tuple((joint_pos_space, joint_vel_space, self.goal_space, ee_space))


        self.sim = GazeboConnection()
        self.sim.load_gazebo_models() # load only baxter and table

    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]

    def preprocess_obs(self, state):
        obs_joint_angle_list = []
        for (lower, upper, _, _), action in zip(constraints.values(), state["j_angle"]):
            obs_joint_angle_list.append(np.clip(action, lower, upper))

        obs_joint_velocity_list = []
        for (_, _, velocity, _), action in zip(constraints.values(), state["j_vel"]):
            obs_joint_velocity_list.append(np.clip(action, -velocity, velocity))

        obs_oint_end_effector = np.clip(state["ee_p"], self.min_joint_pos, self.max_joint_pos)

        obs_joint_gripper = np.clip(state["g_pos"], 0, 1)
        
        
        return obs_joint_angle_list, obs_joint_velocity_list, obs_joint_end_effector, obs_joint_gripper
    def step(self, action):

        t_action = action[0]
        g_action = np.clip(action[1], self.action_space[1].low, self.action_space[1].high)

        torque_list = []
        for (_, _, _, torque), action in zip(constraints.values(), t_action):
            torque_list.append(np.clip(action, -torque, torque))



        self.sim.set_torque_actions(t_action, g_action[0])
        self.sim.step() # step into gazebo
        obs = self.sim.get_obs()
        np_obs = np.array([obs["j_angle"], obs["j_vel"], obs["ee_p"], obs["g_pos"]]) # represents 1d obsrvation for network
        # helper function for magnitude of error
        mag_2 = lambda x_pos, g_pos : math.sqrt(math.pow(x_pos[0] - g_pos[0],2) + 
                                                    math.pow(x_pos[1] - g_pos[1],2) +
                                                    math.pow(x_pos[2] - g_pos[2],2))

        done = mag_2(obs["ee_p"], self.goal) < 0.05 # in m
        excess_torque_penalty = math.sqrt(action[0]*action[0] + action[1]*action[1] + 
                                action[2]*action[2] + action[3]*action[3] + action[4]*action[4] + 
                                action[5]*action[5] + action[6]*action[6])

        reward = - mag_2(self.goal, obs["ee_p"]) - self.c_a * excess_torque_penalty

        return np_obs, reward, done, {}

    def reset(self):
        # Attempt to reset the simulator. Since we randomize initial conditions, it
        # is possible to get into a state with numerical issues (e.g. due to penetration or
        # Gimbel lock) or we may not achieve an initial condition (e.g. an object is within the hand).
        # In this case, we just keep randomizing until we eventually achieve a valid initial
        # configuration.

        # @todo

        # reset baxter
        self.sim.reset()

        # delete only blocks
        self.sim.delete_gazebo_models(True)

        self.goal = self._sample_goal().copy()
        
        # spawn block at goal location

         
        obs = self._get_obs()
        np_obs = np.array([obs["j_angle"], obs["j_vel"], obs["ee_p"], obs["g_pos"]])
        return np_obs

    def _sample_goal(self):
        """Samples a new goal and returns it.
        """
        
        goal = self.goal_space.sample() + self.np_random.uniform(-self.u_bound_goal, self.u_bound_goal, size=3)
        goal[2] = self.height_offset

        # adding extra noise to goal
        # if self.target_in_the_air and self.np_random.uniform() < 0.5:
        #     goal[2] += self.np_random.uniform(0, 0.45)
        return goal.copy()


    def close():
        pass


def test_env(self):
    pass

if __name__ == "__main__":
    test_env()