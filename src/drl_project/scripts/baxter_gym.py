#!/usr/bin/env python3.7
import os
import copy
import numpy as np
import gym
from gym import error, spaces
from gym.utils import seeding
import rospy
import math
from stable_baselines3.common.env_checker import check_env

from geometry_msgs.msg import (
    PoseStamped,
    Pose,
    Point,
    Quaternion,
)

from drl_project.srv import (DeleteGazeboModels, DeleteGazeboModelsRequest,
                            GetObs, GetObsRequest,
                            LoadGazeboModels, LoadGazeboModelsRequest,
                            Reset, ResetRequest,
                            SetTorque, SetTorqueRequest,
                            SpawnBlocks, SpawnBlocksRequest  )

def goal_distance(goal_a, goal_b):
    assert goal_a.shape == goal_b.shape
    return np.linalg.norm(goal_a - goal_b, axis=-1)



class BaxterGym(gym.Env):

    def __init__(self):
        self.seed()
   

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
        self.constraints =   {"left_s0" : (-1.70167993878, 1.70167993878, 1.5, 50),
                        "left_s1" : (-2.147, 1.047, 1.5, 50),
                        "left_e0" : (-3.05417993878, 3.05417993878, 1.5, 50),
                        "left_e1" : (-0.05, 2.618, 1.5, 50),
                        "left_w0" : (-3.059, 3.059, 4.0, 15),
                        "left_w1" : (-1.57079632679, 2.094, 4.0, 15),
                        "left_w2" : (-3.059, 3.059, 4.0, 15)}

        # valid x and y goals
        torque_space = spaces.Box(self.max_torque, self.min_torque,
                                         shape=(7, ), dtype='float32') # adjust later for range
        #self.reward_range = (-1, 0)
        gripper_space = spaces.Box(0, 1, (1,))
        self.action_space = spaces.Tuple((torque_space, gripper_space))
        joint_pos_space = spaces.Box(self.min_joint_pos, self.max_joint_pos, shape=(7, ), dtype='float32')
        joint_vel_space = spaces.Box(self.min_joint_vel, self.max_joint_vel, shape=(7, ), dtype='float32')
        self.goal_space = spaces.Box(np.array([self.min_valid_pos_x, self.min_valid_pos_y]), 
                                     np.array([self.max_valid_pos_x, self.max_valid_pos_y]), 
                                        shape=(2,), dtype='float32')
                
        ee_space = spaces.Box(0, 1, (1,))
        self.observation_space = spaces.Tuple((joint_pos_space, joint_vel_space, self.goal_space, ee_space))
        self.goal = self._sample_goal() # initial sample goal
        self.load_gazebo_models_client() # load only baxter and table
        rospy.loginfo("Baxter Gym Created Successfully")



    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]

    def preprocess_obs(self, state):
        obs_joint_angle_list = []
        for (lower, upper, _, _), action in zip(self.constraints.values(), state["j_angle"]):
            obs_joint_angle_list.append(np.clip(action, lower, upper))

        obs_joint_velocity_list = []
        for (_, _, velocity, _), action in zip(self.constraints.values(), state["j_vel"]):
            obs_joint_velocity_list.append(np.clip(action, -velocity, velocity))

        obs_joint_end_effector = np.clip(state["ee_p"], self.min_joint_pos, self.max_joint_pos)
        obs_joint_gripper = np.clip(state["g_pos"], 0, 1)
        
        return obs_joint_angle_list, obs_joint_velocity_list, obs_joint_end_effector, obs_joint_gripper
    
    # clients
    def load_gazebo_models_client(self):
        rospy.wait_for_service('load_gazebo_models')
        try:
            load_gazebo_models = rospy.ServiceProxy('load_gazebo_models', LoadGazeboModels)
            req = LoadGazeboModelsRequest([0.75, 0.5, 0.0], "world", [0.6725, 0.1265, 0.7825], "world")
            load_gazebo_models(req)
        except rospy.ServiceException as e:
            print("Load gazebo failed: ", e)

    def set_torque_client(self, t_action, g_action):
        rospy.wait_for_service('set_torque')
        try:
            req = SetTorqueRequest(t_action, g_action)
            set_torque = rospy.ServiceProxy('set_torque', SetTorque)
            set_torque(req)
        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def get_obs_client(self):
        rospy.wait_for_service('get_obs')
        try:
            get_obs = rospy.ServiceProxy('get_obs', GetObs)
            _obs = get_obs()
            assert len(_obs) == 16
            obs = {}
            obs["j_angle"] = _obs[:7]
            obs["j_vel"] = _obs[7:14]
            obs["ee_p"] = _obs[15]
            obs["g_pos"] = _obs[16]
            return obs

        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def reset_client(self):
        rospy.wait_for_service('reset')
        try:
            reset = rospy.ServiceProxy('reset', SpawnBlocks)
            reset()
        except rospy.ServiceException as e:
            print("reset failed: ", e)

    # delete only blocks
    def delete_gazebo_models_client(self, blockOnly):
        rospy.wait_for_service('delete_gazebo_models')
        try:
            delete_gazebo_models = rospy.ServiceProxy('delete_gazebo_models', SpawnBlocks)
            delete_gazebo_models(blockOnly)

            req = DeleteGazeboModelsRequest(blockOnly)
            delete_gazebo_models = rospy.ServiceProxy('delete_gazebo_models', DeleteGazeboModels)
            delete_gazebo_models(req)
        except rospy.ServiceException as e:
            print("delete_gazebo_models failed: ", e)

        
    # spawn block at goal location  
    def spawn_blocks_client(self):
        rospy.wait_for_service('spawn_blocks')
        try:
            spawn_blocks = rospy.ServiceProxy('spawn_blocks', SpawnBlocks)
            spawn_blocks(self.goal)

            req = SpawnBlocks(t_action, g_action)
            spawn_blocks = rospy.ServiceProxy('spawn_blocks', SpawnBlocks)
            spawn_blocks(req)
        except rospy.ServiceException as e:
            print("spawn_blocks failed: ", e)
       
    def step(self, action):

        t_action = action[0]
        g_action = np.clip(action[1], self.action_space[1].low, self.action_space[1].high)

        torque_list = []
        for (_, _, _, torque), action in zip(self.constraints.values(), t_action):
            torque_list.append(np.clip(action, -torque, torque))

        self.set_torque_client(t_action, g_action[0])
        # step
        obs = self.get_obs_client()
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
        self.reset_client()

        # delete only blocks
        self.delete_gazebo_models_client(True)

        self.goal = self._sample_goal().copy()
        
        # spawn block at goal location
        self.spawn_blocks_client()

        obs = self.get_obs_client()
        obs = self.preprocess_obs(obs)
        np_obs = np.array([obs[0], obs[1], obs[2], obs[3]]).flatten()
        return np_obs

    def _sample_goal(self):
        """Samples a new goal and returns it.
        """
        goal = self.goal_space.sample() + self.np_random.uniform(-self.u_bound_goal, self.u_bound_goal, size=2)
        # adding extra noise to goal
        # if self.target_in_the_air and self.np_random.uniform() < 0.5:
        #     goal[2] += self.np_random.uniform(0, 0.45)
        return goal.copy()

    def close(self):
        self.delete_gazebo_models_client(False)


def main():
    rospy.init_node("baxter_gym")
    # Wait for the All Clear from emulator startup

    env = BaxterGym()
    #check_env(env)
    rospy.spin()

if __name__ == "__main__":
    main()