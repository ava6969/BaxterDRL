#!/usr/bin/env python3
import os
import copy
import numpy as np
import gym
from gym.envs.registration import register
from gym import error, spaces
from gym.utils import seeding
import rospy
import math
from ray.tune.registry import register_env
from gazebo_connection import GazeboConnection
from geometry_msgs.msg import (
    PoseStamped,
    Pose,
    Point,
    Quaternion,
)
from stable_baselines3.common.env_checker import check_env
import time
from drl_project.srv import (DeleteGazeboModels, DeleteGazeboModelsRequest,
                            GetObs, GetObsRequest,
                            LoadGazeboModels, LoadGazeboModelsRequest,
                            Reset, ResetRequest,
                            SetTorque, SetTorqueRequest,
                            SpawnBlocks, SpawnBlocksRequest  )

def goal_distance(goal_a, goal_b):
    assert goal_a.shape == goal_b.shape
    return np.linalg.norm(goal_a - goal_b, axis=-1)


class BaxterEnv(gym.Env):

    def __init__(self, env_config=None):
        self.seed()
        self.gazebo = GazeboConnection()
        # services
        self.reset_ = rospy.ServiceProxy('reset', Reset, persistent=False)
        self.delete_gazebo_models = rospy.ServiceProxy('delete_gazebo_models', DeleteGazeboModels,  persistent=False)
        self.spawn_blocks = rospy.ServiceProxy('spawn_blocks', SpawnBlocks,  persistent=False)
        self.load_gazebo_models = rospy.ServiceProxy('load_gazebo_models', LoadGazeboModels, persistent=False)
        self.set_torque_ = rospy.ServiceProxy('set_torque', SetTorque, persistent=False)
        self.get_obs = rospy.ServiceProxy('get_obs', GetObs, persistent=False)

        # gets training parameters from param server
        self.running_step = 0.008

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
        self.loopRate = rospy.Rate(10)
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
        gripper_space = spaces.Box(0, 100, (1,))
        #self.action_space = spaces.Tuple((torque_space, gripper_space))
        self.action_space = spaces.Box(-1, 1, (8,))

        joint_pos_space = spaces.Box(self.min_joint_pos, self.max_joint_pos, shape=(7, ), dtype='float32')
        joint_vel_space = spaces.Box(self.min_joint_vel, self.max_joint_vel, shape=(7, ), dtype='float32')
        ee_space = spaces.Box(-np.inf, np.inf, (3,))

        self.goal_space = spaces.Box(np.array([self.min_valid_pos_x, self.min_valid_pos_y, -0.2]), 
                                     np.array([self.max_valid_pos_x, self.max_valid_pos_y, 0.2]),
                       
                                     dtype='float32')
                
        self.observation_space = spaces.Box(-np.inf, np.inf, (21,))
        #self.observation_space = spaces.Tuple((joint_pos_space, joint_vel_space, ee_space, gripper_space, self.goal_space ))
        self.goal = self._sample_goal() # initial sample goal
        self.load_gazebo_models_client() # load table
        rospy.loginfo("Baxter Gym Created Successfully")

    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]
    
    # clients
    def load_gazebo_models_client(self):
        rospy.wait_for_service('load_gazebo_models')
        try:
            req = LoadGazeboModelsRequest([0.75, 0.5, 0.0], "world", [0.6725, 0.1265, 0.7825], "world")
            self.load_gazebo_models(req)
        except rospy.ServiceException as e:
            print("Load gazebo failed: ", e)

    def set_torque_client(self, t_action, g_action):
        rospy.wait_for_service('set_torque')
        try:
            req = SetTorqueRequest(t_action, g_action)
            self.set_torque_(req)
        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def get_obs_client(self):
        rospy.wait_for_service('get_obs')
        try:
            _obs = self.get_obs().obs
            assert len(_obs) == 18

            obs = {}
            sample1 = self.np_random.uniform(-self.u_bound_goal, self.u_bound_goal, size=7)
            sample2 = self.np_random.uniform(-0.1, 0.1, size=7)
            angle = _obs[:7] +  sample1
            vel = _obs[7:14] +  sample2

            obs["j_angle"] = angle
            obs["j_vel"] = vel
            obs["ee_p"] = _obs[14:17]
            obs["g_pos"] = _obs[17]
            _obs = []
            _obs.extend(angle)
            _obs.extend(vel)
            _obs.extend(obs["ee_p"])
            _obs.append(obs["g_pos"])
            return obs, _obs

        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def reset_client(self):
        rospy.wait_for_service('reset')
        try:
            self.reset_()
        except rospy.ServiceException as e:
            print("reset failed: ", e)

    # delete only blocks
    def delete_gazebo_models_client(self, blockOnly):
        rospy.wait_for_service('delete_gazebo_models')
        try:
            req = DeleteGazeboModelsRequest(blockOnly)
            self.delete_gazebo_models(req)
        except rospy.ServiceException as e:
            print("delete_gazebo_models failed: ", e)

        
    # spawn block at goal location  
    def spawn_blocks_client(self):
        rospy.wait_for_service('spawn_blocks')
        try:
            req = SpawnBlocksRequest(self.goal, "world")
            self.spawn_blocks(req)
        except rospy.ServiceException as e:
            print("spawn_blocks failed: ", e)
       
    def step(self, action):

        #print("raw action: ", action)
        t_action = action[:7]
        g_action = action[7]*50.0 + 50.0# -1*50 + 50 = 0 1*50 + 50 = 100

        torque_list = []
        for (_, _, _, torque), action in zip(self.constraints.values(), t_action):
            torque_list.append(torque * action)
       

        self.gazebo.unpauseSim()
        self.set_torque_client(torque_list, g_action)
        rospy.sleep(self.running_step) # figure out what running step
        obs, obs_raw = self.get_obs_client()
        self.gazebo.pauseSim()
  

        np_obs = np.array(obs_raw, np.float)
        np_obs = np.append(np_obs, self.goal[0])
        np_obs = np.append(np_obs, self.goal[1])
        np_obs = np.append(np_obs, self.goal[2])
        
        # helper function for magnitude of error

        # include x y z
        # mag_2 = lambda x_pos, g_pos : math.sqrt(math.pow(x_pos[0] - g_pos[0],2) + 
        #                                             math.pow(x_pos[1] - g_pos[1],2) + 
        #                                             math.pow(x_pos[2] - g_pos[2], 2))
        
        mag_obs = goal_distance(np.array(obs["ee_p"]), self.goal)
      
       # print("diff goal - ee", mag_obs)
        done = mag_obs < 0.05 # in m
        excess_torque_penalty = math.sqrt(torque_list[0]*torque_list[0] + torque_list[1]*torque_list[1] + 
                                torque_list[2]*torque_list[2] + torque_list[3]*torque_list[3] + torque_list[4]*torque_list[4] + 
                                torque_list[5]*torque_list[5] + torque_list[6]*torque_list[6])

        #print("torque penalty: ", excess_torque_penalty)

        reward = - mag_obs - self.c_a * excess_torque_penalty
        #print("reward: ", reward)
        #print("done ", done)
    
        return np_obs, reward, done, {}

    def reset(self):
        # Attempt to reset the simulator. Since we randomize initial conditions, it
        # is possible to get into a state with numerical issues (e.g. due to penetration or
        # Gimbel lock) or we may not achieve an initial condition (e.g. an object is within the hand).
        # In this case, we just keep randomizing until we eventually achieve a valid initial
        # configuration.

        # @todo
        # 1st: resets the simulation to initial values
        #self.gazebo.resetSim()

        # 2nd: Unpauses simulation
        self.gazebo.unpauseSim()

        # reset baxter
        self.reset_client()


        # delete only blocks
        self.delete_gazebo_models_client(True)

        self.goal = self._sample_goal().copy()
        
        # spawn block at goal location
        self.spawn_blocks_client()

        # np_obs = np.array([obs_raw, self.goal[0], slef.goals[1]]).flatten()
        #np_obs = np.array([obs["j_angle"], obs["j_vel"], obs["ee_p"], obs["g_pos"], self.goal])
        _, obs_raw = self.get_obs_client()

        self.gazebo.pauseSim()
        
        obs = np.array(obs_raw, np.float)
        obs = np.append(obs, self.goal[0])
        obs = np.append(obs, self.goal[1])
        obs = np.append(obs, self.goal[2])


        return obs

    def _sample_goal(self):
        """Samples a new goal and returns it.
        """
        goal = self.goal_space.sample() + self.np_random.uniform(-self.u_bound_goal, self.u_bound_goal, size=3)
        # adding extra noise to goal
        # if self.target_in_the_air and self.np_random.uniform() < 0.5:
        #     goal[2] += self.np_random.uniform(0, 0.45)
        # goal = np.append(goal, 0.15)
        return goal.copy()

    def close(self):
        self.delete_gazebo_models_client(False)

if __name__ == '__main__':
    rospy.init_node('mbaxter_gym', anonymous=True)
    env = BaxterEnv()
    rospy.on_shutdown(env.close)
    rospy.spin()