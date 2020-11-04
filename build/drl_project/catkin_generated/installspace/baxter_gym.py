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
        gripper_space = spaces.Box(0, 100, (1,))
        #self.action_space = spaces.Tuple((torque_space, gripper_space))
        self.action_space = spaces.Box(-1, 1, (8,))

        joint_pos_space = spaces.Box(self.min_joint_pos, self.max_joint_pos, shape=(7, ), dtype='float32')
        joint_vel_space = spaces.Box(self.min_joint_vel, self.max_joint_vel, shape=(7, ), dtype='float32')
        ee_space = spaces.Box(-np.inf, np.inf, (3,))
        self.goal_space = spaces.Box(np.array([self.min_valid_pos_x, self.min_valid_pos_y]), 
                                     np.array([self.max_valid_pos_x, self.max_valid_pos_y]), 
                                     dtype='float32')
                
        self.observation_space = spaces.Box(-4, 4, (20,))
        #self.observation_space = spaces.Tuple((joint_pos_space, joint_vel_space, ee_space, gripper_space, self.goal_space ))
        self.goal = self._sample_goal() # initial sample goal
        self.load_gazebo_models_client() # load only baxter and table
        rospy.loginfo("Baxter Gym Created Successfully")


    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]

    def preprocess_obs(self, state):
        # obs_joint_angle_list = []
        # for (lower, upper, _, _), action in zip(self.constraints.values(), state["j_angle"]): # 7
        #     obs_joint_angle_list.append(np.clip(action, lower, upper))

        # obs_joint_velocity_list = []
        # for (_, _, velocity, _), action in zip(self.constraints.values(), state["j_vel"]): # 7
        #     obs_joint_velocity_list.append(np.clip(action, -velocity, velocity))

        # obs_joint_end_effector = state["ee_p"] # 3

        # obs_joint_gripper = state["goal_p"]
        #           7 dim           7 dim           3 dim           2 dim - z is fixed
        return state["j_angle"], state["j_vel"], state["ee_p"], state["g_p"]
    
    # clients
    def load_gazebo_models_client(self):
        rospy.wait_for_service('load_gazebo_models')
        try:
            load_gazebo_models = rospy.ServiceProxy('load_gazebo_models', LoadGazeboModels, persistent=True)
            req = LoadGazeboModelsRequest([0.75, 0.5, 0.0], "world", [0.6725, 0.1265, 0.7825], "world")
            load_gazebo_models(req)
        except rospy.ServiceException as e:
            print("Load gazebo failed: ", e)

    def set_torque_client(self, t_action, g_action):
        rospy.wait_for_service('set_torque')
        try:
            req = SetTorqueRequest(t_action, g_action)
            set_torque = rospy.ServiceProxy('set_torque', SetTorque, persistent=True)
            set_torque(req)
        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def get_obs_client(self):
        rospy.wait_for_service('get_obs')
        try:
            get_obs = rospy.ServiceProxy('get_obs', GetObs, persistent=True)
            _obs = get_obs().obs
            assert len(_obs) == 18

            obs = {}
            obs["j_angle"] = _obs[:7]
            obs["j_vel"] = _obs[7:14]
            obs["ee_p"] = _obs[14:17]
            obs["g_pos"] = _obs[17]
            return obs, _obs

        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def reset_client(self):
        rospy.wait_for_service('reset')
        try:
            reset = rospy.ServiceProxy('reset', Reset, persistent=True)
            reset()
        except rospy.ServiceException as e:
            print("reset failed: ", e)

    # delete only blocks
    def delete_gazebo_models_client(self, blockOnly):
        rospy.wait_for_service('delete_gazebo_models')
        try:
            req = DeleteGazeboModelsRequest(blockOnly)
            delete_gazebo_models = rospy.ServiceProxy('delete_gazebo_models', DeleteGazeboModels,  persistent=True)
            delete_gazebo_models(req)
        except rospy.ServiceException as e:
            print("delete_gazebo_models failed: ", e)

        
    # spawn block at goal location  
    def spawn_blocks_client(self):
        rospy.wait_for_service('spawn_blocks')
        try:
            req = SpawnBlocksRequest(self.goal, "world")
            spawn_blocks = rospy.ServiceProxy('spawn_blocks', SpawnBlocks,  persistent=True)
            spawn_blocks(req)
        except rospy.ServiceException as e:
            print("spawn_blocks failed: ", e)
       
    def step(self, action):

        print("raw action: ", action)
        t_action = action[:7]
        g_action = action[1]*50.0 + 50.0# -1*50 + 50 = 0 1*50 + 50 = 100

        torque_list = []
        for (_, _, _, torque), action in zip(self.constraints.values(), t_action):
            torque_list.append(torque * action)
        print("unnorm actions: ", torque_list, g_action)
        self.set_torque_client(torque_list, g_action)

        obs, obs_raw = self.get_obs_client()
        np_obs = np.array(obs_raw, np.float)
        np_obs = np.append(np_obs, self.goal[0])
        np_obs = np.append(np_obs, self.goal[1])
        
        # helper function for magnitude of error
        mag_2 = lambda x_pos, g_pos : math.sqrt(math.pow(x_pos[0] - g_pos[0],2) + 
                                                    math.pow(x_pos[1] - g_pos[1],2))
      
        mag_obs = mag_2(obs["ee_p"], self.goal)
        print("diff goal - ee", mag_obs)
        done = mag_obs < 0.05 # in m
        excess_torque_penalty = math.sqrt(torque_list[0]*torque_list[0] + torque_list[1]*torque_list[1] + 
                                torque_list[2]*torque_list[2] + torque_list[3]*torque_list[3] + torque_list[4]*torque_list[4] + 
                                torque_list[5]*torque_list[5] + torque_list[6]*torque_list[6])

        print("torque penalty: ", excess_torque_penalty)

        reward = - mag_2(self.goal, obs["ee_p"]) - self.c_a * excess_torque_penalty
        print("reward: ", reward)
        print("done ", done)

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

        # np_obs = np.array([obs_raw, self.goal[0], slef.goals[1]]).flatten()
        #np_obs = np.array([obs["j_angle"], obs["j_vel"], obs["ee_p"], obs["g_pos"], self.goal])
        _, obs_raw = self.get_obs_client()
        obs = np.array(obs_raw, np.float)
        obs = np.append(obs, self.goal[0])
        obs = np.append(obs, self.goal[1])

        return obs

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
    check_env(env)
    # env.close()
    rospy.spin()

if __name__ == "__main__":
    main()