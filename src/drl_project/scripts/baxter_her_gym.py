#!/usr/bin/env python3

import os
import copy
import numpy as np
import gym
from gym import error, spaces
from gym.utils import seeding
import rospy
from gazebo_connection import GazeboConnection

def goal_distance(goal_a, goal_b):
    assert goal_a.shape == goal_b.shape
    return np.linalg.norm(goal_a - goal_b, axis=-1)

class BaxterHERGym(gym.GoalEnv):

    def __init__(self):
        self.seed()
        self._env_setup(initial_qpos) # initial robot with desired joints angle
        self.initial_state = None # get sim state
        self.goal = self._sample_goal() # initial sample goal
        obs = self._get_obs() # get observation
        self.action_range = spaces.Box(-1, 1, shape=(4, ), dtype='float32') # adjust later for range
        self.observation_space = spaces.Dict(dict(
            desired_goal=spaces.Box(-np.inf, np.inf, shape=obs['achieved_goal'].shape, dtype='float32'),
            achieved_goal=spaces.Box(-np.inf, np.inf, shape=obs['achieved_goal'].shape, dtype='float32'),
            observation=spaces.Box(-np.inf, np.inf, shape=obs['observation'].shape, dtype='float32'),
        ))
        #self.running_step =
        self.sim = GazeboConnection()
        self.sim.load_gazebo_models()
        self.distance_threshold = 0.05

    def compute_reward(self, achieved_goal, goal, info):
        # Compute distance between goal and the achieved goal.
        d = goal_distance(achieved_goal, goal)
        return -(d > self.distance_threshold).astype(np.float32)

    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]

    def step(self, action):
        action = np.clip(action, self.action_space.low, self.action_space.high)
        self._set_action(action)
        self.sim.step() # step into gazebo
        self._step_callback() 
        obs = self._get_obs()

        done = False
        info = {
            'is_success': self._is_success(obs['achieved_goal'], self.goal),
        }
        reward = self.compute_reward(obs['achieved_goal'], self.goal, info)
        return obs, reward, done, info

    def reset(self):
        # Attempt to reset the simulator. Since we randomize initial conditions, it
        # is possible to get into a state with numerical issues (e.g. due to penetration or
        # Gimbel lock) or we may not achieve an initial condition (e.g. an object is within the hand).
        # In this case, we just keep randomizing until we eventually achieve a valid initial
        # configuration.
        super(BaxterGym, self).reset()
        did_reset_sim = False
        while not did_reset_sim:
            did_reset_sim = self._reset_sim()
        self.goal = self._sample_goal().copy() 
        obs = self._get_obs()
        return obs

        # resolve condition for termination
    def _reset_sim(self):
        """Resets a simulation and indicates whether or not it was successful.
        If a reset was unsuccessful (e.g. if a randomized state caused an error in the
        simulation), this method should indicate such a failure by returning False.
        In such a case, this method will be called again to attempt a the reset again.
        """
        self._reset_sim()

        # Randomize start position of object.
        object_xpos = self.initial_gripper_xpos[:2]
        while np.linalg.norm(object_xpos - self.initial_gripper_xpos[:2]) < 0.1:
            object_xpos = self.initial_gripper_xpos[:2] + self.np_random.uniform(-self.obj_range, self.obj_range, size=2)
        
        # @ todo
        # move object to desired random position
        # object_qpos = self.sim.data.get_joint_qpos('object0:joint')
        # assert object_qpos.shape == (7,)
        # object_qpos[:2] = object_xpos
        # self.sim.data.set_joint_qpos('object0:joint', object_qpos)
        # self.sim.forward()
        return True

    def _get_obs(self):
        """Returns the observation.
        """
        # positions
        grip_pos = self.obs_sub['gripper_pos'].x
        # dt = self.sim.nsubsteps * self.sim.model.opt.timestep
        grip_velp = self.obs_sub['gripper_vel'].x
        robot_qpos, robot_qvel = self.obs_sub['robot_pos'], self.obs_sub['robot_vel']
        
        object_pos = self.obs_sub['object0_pos'].x
        # rotations
        object_rot = self.obs_sub['object0_rot'] # make sure euler
        # velocities
        object_velp = self.obs_sub['object0_xvel'].p* dt
        object_velr = self.obs_sub['object0_xvel'].r * dt
        # gripper state
        object_rel_pos = object_pos - grip_pos
        object_velp -= grip_velp
        
        # @todo find gripper_state = robot_qpos[-2:]
        # @todo find gripper_vel = robot_qvel[-2:] * dt  # change to a scalar if the gripper is made symmetric

        achieved_goal = np.squeeze(object_pos.copy())
        obs = np.concatenate([
            grip_pos, object_pos.ravel(), object_rel_pos.ravel(), gripper_state, object_rot.ravel(),
            object_velp.ravel(), object_velr.ravel(), grip_velp, gripper_vel,
        ])

        return {
            'observation': obs.copy(),
            'achieved_goal': achieved_goal.copy(),
            'desired_goal': self.goal.copy(),
        }

    def _is_success(self, achieved_goal, desired_goal):
        """Indicates whether or not the achieved goal successfully achieved the desired goal.
        """
        d = goal_distance(achieved_goal, desired_goal)
        return (d < self.distance_threshold).astype(np.float32)

    def _sample_goal(self):
        """Samples a new goal and returns it.
        """
        goal = self.initial_gripper_xpos[:3] + self.np_random.uniform(-self.target_range, self.target_range, size=3)
        goal += self.target_offset
        goal[2] = self.height_offset
        if self.target_in_the_air and self.np_random.uniform() < 0.5:
            goal[2] += self.np_random.uniform(0, 0.45)
        return goal.copy()

    def _env_setup(self ):
        """Initial configuration of the environment. Can be used to configure initial state
        and extract information from the simulation.
        """
        # @todo: set all joints to default configuration with end effector at center
        self.gazebo.move_to_start(self.starting_joint_angles)
        # step in environment

        # get gripper xpos 
        self.initial_gripper_xpos = self.obs['gripper'].x
        # get object height offset
        self.height_offset = None # replace with block height 

    def _step_callback(self):
        """A custom callback that is called after stepping the simulation. Can be used
        to enforce additional constraints on the simulation state.
        """
        pass



    def close():
        pass