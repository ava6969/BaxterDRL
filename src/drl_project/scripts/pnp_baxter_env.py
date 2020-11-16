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
from gazebo_connection import GazeboConnection
from geometry_msgs.msg import (
    PoseStamped,
    Pose,
    Point,
    Quaternion,
)
from stable_baselines3.common.env_checker import check_env
import time
from drl_project.srv import (DeleteGazeboModelsWithTarget, DeleteGazeboModelsWithTargetRequest,
                            GetObs, GetObsRequest,
                            LoadGazeboModelsWithTarget, LoadGazeboModelsWithTargetRequest,
                            Reset, ResetRequest,
                            SetTorque, SetTorqueRequest,
                            Logger, LoggerRequest,
                            SpawnBlocksWithTarget, SpawnBlocksWithTargetRequest  )

def mag_distance(goal_a, goal_b):
    assert goal_a.shape == goal_b.shape
    return np.linalg.norm(goal_a - goal_b, axis=-1)

#register the training environment in the gym as an available one
reg = register(
    id='PnPBaxter-v0',
    entry_point='pnp_baxter_env:PnPBaxterEnv',
    max_episode_steps=500,
    )


class PnPBaxterEnv(gym.Env):

    def __init__(self):
        self.seed()
        self.gazebo = GazeboConnection()
        # services
        self.reset_ = rospy.ServiceProxy('reset_t', Reset, persistent=False)
        self.delete_gazebo_models = rospy.ServiceProxy('delete_gazebo_models_t', DeleteGazeboModelsWithTarget,  persistent=False)
        self.spawn_blocks = rospy.ServiceProxy('spawn_blocks_t', SpawnBlocksWithTarget,  persistent=False)
        self.load_gazebo_models = rospy.ServiceProxy('load_gazebo_models_t', LoadGazeboModelsWithTarget, persistent=False)
        self.set_torque_ = rospy.ServiceProxy('set_torque_t', SetTorque, persistent=False)
        self.get_obs = rospy.ServiceProxy('get_obs_t', GetObs, persistent=False)
        self.log = rospy.ServiceProxy('log', Logger)
        # gets training parameters from param server
        self.running_step = 0.008

        # hyperparams
        self.c_a = 1e-3 # regularization term
        self.c = [0.4, 0.2, 0.4] # [ee-obj-weight, fingers-obj-weight, obj-goal-weight]
        self.step_ctr = 0
        self.mag_obs = 0

        # assuming all joints have maz torques
        # add obj info for next experiment
        # put max torque and min torque, create different spaces for tehm,
        self.max_torque, self.min_torque = 50, -50
        self.max_joint_pos, self.min_joint_pos = 3.059, -3.059
        self.max_joint_vel, self.min_joint_vel = 4, -4
        self.max_valid_pos_x, self.min_valid_pos_x = 0.80, 0.50
        self.max_valid_pos_y, self.min_valid_pos_y = 0.4, 0.1
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

        self.goal_space = spaces.Box(np.array([self.min_valid_pos_x, self.min_valid_pos_y]), 
                                     np.array([self.max_valid_pos_x, self.max_valid_pos_y]),
                                     dtype='float32')
                
        self.observation_space = spaces.Box(-np.inf, np.inf, (27,))
        self.goal = self._sample_goal() # initial sample goal
        self.msg = ""
        self.load_gazebo_models_client() # load table
        rospy.loginfo("Baxter Gym Created Successfully")

    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]
    
    # clients
    def load_gazebo_models_client(self):
        rospy.wait_for_service('load_gazebo_models_t')
        try:
            req = LoadGazeboModelsWithTargetRequest([1.05, 0.5, 0.0], "world", [0.6725, 0.1265, 0.3], "world")
            self.load_gazebo_models(req)
        except rospy.ServiceException as e:
            print("Load gazebo failed: ", e)

    def set_torque_client(self, t_action, g_action):
        rospy.wait_for_service('set_torque_t')
        try:
            req = SetTorqueRequest(t_action, g_action)
            self.set_torque_(req)
        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def get_obs_client(self):
        rospy.wait_for_service('get_obs_t')
        try:
            _obs = self.get_obs().obs
            assert len(_obs) == 27

            obs = {}
        

            obs["j_angle"] = _obs[:7]
            obs["j_vel"] = _obs[7:14]
            obs["ee_pos"] = _obs[14:17]
            obs["gripper_pos"] = _obs[17]
            obs["lf_pos"] = _obs[18:21]
            obs["rf_pos"] = _obs[21:24]
            obs["obj_pos"] = _obs[24:27]

        
            _obs = []
            _obs.extend(obs["j_angle"])
            _obs.extend(obs["j_vel"])
            _obs.extend(obs["ee_pos"])
            _obs.append(obs["gripper_pos"])
            _obs.extend(obs["obj_pos"])

            
            return obs, _obs

        except rospy.ServiceException as e:
            print("set_torque failed: ", e)

    def reset_client(self):
        rospy.wait_for_service('reset_t')
        try:
            self.reset_()
        except rospy.ServiceException as e:
            print("reset failed: ", e)

    # delete only blocks
    def delete_gazebo_models_client(self, blockOnly):
        rospy.wait_for_service('delete_gazebo_models_t')
        try:
            req = DeleteGazeboModelsWithTargetRequest(blockOnly)
         
            self.delete_gazebo_models(req)
        except rospy.ServiceException as e:
            print("delete_gazebo_models failed: ", e)
   
    # spawn block at goal location  
    def spawn_blocks_client(self):
        rospy.wait_for_service('spawn_blocks_t')
        try:
            req = SpawnBlocksWithTargetRequest(self.goal, "world")
            self.spawn_blocks(req)
        except rospy.ServiceException as e:
            print("spawn_blocks failed: ", e)
       
    def logger_client(self):
        rospy.wait_for_service('log')
        try:
            req = LoggerRequest(self.msg)
            self.log(req)
        except rospy.ServiceException as e:
            print("logger client failed: ", e)

    def step(self, action):

        # print("raw action: ", action)
        t_action = action[:7]
        g_action = action[7]*50.0 + 50.0# -1*50 + 50 = 0 1*50 + 50 = 100

        torque_list = []
        for (_, _, _, torque), action in zip(self.constraints.values(), t_action):
            torque_list.append(torque * action)
        
        self.msg += f"torques: {t_action}\ngripper action:{g_action}\n"

       
        # print(g_action)
        self.gazebo.unpauseSim()
        self.set_torque_client(torque_list, g_action)
        rospy.sleep(self.running_step) # figure out what running step
        _obs, obs_raw = self.get_obs_client()
        self.gazebo.pauseSim()

        obs = np.array(obs_raw, np.float)
        # target obj
        obs = np.append(obs, _obs["obj_pos"][0])
        obs = np.append(obs, _obs["obj_pos"][1])
        obs = np.append(obs, _obs["obj_pos"][2])
        # goal pos
        
        obs = np.append(obs, self.goal[0])
        obs = np.append(obs, self.goal[1])
        obs = np.append(obs, self.goal[2])

        self.msg += f"goal: {self.goal}"
        

        self.ee_obj_dist = mag_distance(np.array(_obs["ee_pos"]), self.goal)
        self.target_obj_dist =  mag_distance(np.array(_obs["obj_pos"]), self.goal)

        cube_center = 0.025
        lf_to_obj_pos = mag_distance(np.array(_obs["lf_pos"]), np.array(_obs["obj_pos"]))
        rf_to_obj_pos = mag_distance(np.array(_obs["rf_pos"]), np.array(_obs["obj_pos"]))
        self.fingers_com_obj_dist = (lf_to_obj_pos - cube_center) + (rf_to_obj_pos - cube_center)
    
        self.msg += f"Distance of End Effector To Goal - {self.ee_obj_dist}\n"
        self.msg += f"Distance of Object Position To Goal - {self.target_obj_dist}\n"
        self.msg += f"Distance of Left Finger To Object Position - {lf_to_obj_pos}\n"
        self.msg += f"Distance of Right Finger To Object Position - {rf_to_obj_pos}\n"
        self.msg += f"Fingers To Object Position - {self.fingers_com_obj_dist}\n"

        
        done =  bool((self.ee_obj_dist > 0.35) and (self.target_obj_dist > 0.35))
        excess_torque_penalty = math.sqrt(torque_list[0]*torque_list[0] + torque_list[1]*torque_list[1] + 
                                torque_list[2]*torque_list[2] + torque_list[3]*torque_list[3] + torque_list[4]*torque_list[4] + 
                                torque_list[5]*torque_list[5] + torque_list[6]*torque_list[6]) * self.c_a
        self.msg += f"Done:{done}\n"
        self.msg += f"Excess Torque Penalty:{excess_torque_penalty}\n"
        #print("torque penalty: ", excess_torque_penalty)
        dist_weigthing = self.c[0]*self.ee_obj_dist + \
                         self.c[1]*self.fingers_com_obj_dist + \
                         self.c[2]*self.target_obj_dist
        self.msg += f"Weighted Distance :{dist_weigthing}\n"
        reward_temp = 1 / (1 + dist_weigthing)
        reward = reward_temp - excess_torque_penalty
        self.msg += f"Reward :{reward}\n"
        self.logger_client()
        self.step_ctr += 1
        return obs, reward, done, {}

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
      
        # print(f"Reset: step counter - {self.step_ctr} , obs mag - {self.mag_obs}\n")
        self.step_ctr = 0
        self.mag_obs = 0

        # delete only blocks
        self.delete_gazebo_models_client(True)

        self.goal = self._sample_goal().copy()
        # print(self.goal)
        # spawn block at goal location
        self.spawn_blocks_client()

        _obs, obs_raw = self.get_obs_client()
        # print(_obs)
        self.gazebo.pauseSim()
        
        obs = np.array(obs_raw, np.float)
        # target obj
        obs = np.append(obs, _obs["obj_pos"][0])
        obs = np.append(obs, _obs["obj_pos"][1])
        obs = np.append(obs, _obs["obj_pos"][2])
        # goal pos
        
        obs = np.append(obs, self.goal[0])
        obs = np.append(obs, self.goal[1])
        obs = np.append(obs, self.goal[2])

        return obs

    def _sample_goal(self, fixed=True):
        """Samples a new goal in air and returns it.
        """
        # randomly smapled goal
        if fixed:
            goal = np.array([0.7, 0.2, 0.7825 - 0.930000025 + 0.3])
        else:
            goal = self.goal_space.sample()
            goal = np.append(goal, 0.7825 - 0.930000025 + 0.3)
        return goal.copy()

    def close(self):
        self.delete_gazebo_models_client(False)

if __name__ == '__main__':
    rospy.init_node('pnp_baxter_gym', anonymous=True)
  
    env = PnPBaxterEnv()

    check_env(env)
    rospy.on_shutdown(env.close)
    rospy.spin()