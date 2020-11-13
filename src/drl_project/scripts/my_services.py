#!/usr/bin/env python

from std_srvs.srv import Empty
import argparse
import struct
import sys
import copy
import random
import rospy
import rospkg
from sensor_msgs.msg import JointState
from gazebo_msgs.srv import (
    SpawnModel,
    DeleteModel,
)
from geometry_msgs.msg import (
    PoseStamped,
    Pose,
    Point,
    Quaternion,
)
from std_msgs.msg import (
    Header,
    Empty,
)

from baxter_core_msgs.srv import (
    SolvePositionIK,
    SolvePositionIKRequest,
)
import time
import baxter_interface
from gazebo_msgs.msg import LinkStates
import numpy as np

from drl_project.srv import (DeleteGazeboModels,DeleteGazeboModelsResponse,
                            GetObs, GetObsResponse,
                            LoadGazeboModels, LoadGazeboModelsResponse,
                            Reset, ResetResponse,
                            SetTorque, SetTorqueResponse,
                            SpawnBlocks, SpawnBlocksResponse  )



class Services():
    def __init__(self, limb, hover_distance = 0.15, verbose=True):
        self._limb_name = limb # string
        self._hover_distance = hover_distance # in meters
        self._verbose = verbose # bool
        self._limb = baxter_interface.Limb(limb)
        self._gripper = baxter_interface.Gripper(limb)
        self.obj_sub = rospy.Subscriber("/gazebo/link_states", LinkStates, self.ls_callback)

        ns = "ExternalTools/" + limb + "/PositionKinematicsNode/IKService"
        self._iksvc = rospy.ServiceProxy(ns, SolvePositionIK)
        rospy.wait_for_service(ns, 5.0)
        # verify robot is enabled
        print("Getting robot state... ")
        self._rs = baxter_interface.RobotEnable(baxter_interface.CHECK_VERSION)
        self._init_state = self._rs.state().enabled
        print("Enabling robot... ")
        #self.pre_proc_sub = rospy.Subscriber("/preproc",JointState,self.update_state)
        self._rs.enable()
        self.block_state = []
        self.overhead_orientation = Quaternion(
                        x=-0.0249590815779,
                        y=0.999649402929,
                        z=0.00737916180073,
                        w=0.00486450832011)
        self.np_random = np.random.RandomState()

    def set_torque(self, req):
        t_actions, g_actions = req.t_value, req.g_value
        torque_dict = {k:v for k, v in zip(self._limb.joint_names(), t_actions)}
        
        # print(torque_dict)
        # print(g_actions)
        self._limb.set_joint_torques(torque_dict)
        self._gripper.command_position(g_actions)
        #rospy.sleep(1)
        response = SetTorqueResponse()
        return response

    def get_obs_(self, req):
        obs = []
        obs.extend(self._limb.joint_angles().values()) # "j_angle"
        obs.extend(self._limb.joint_velocities().values()) # j_vel
        ee = self._limb.endpoint_pose()["position"]
        # print('end effector pose', ee)
        obs.extend([ee.x, ee.y, ee.z]) # ee_p
        #print("ep vel", self._limb.endpoint_velocity()) provide velocities as state to see if it imporves
        obs.append(self._gripper.position() / 100) # gripper_pos
        response = GetObsResponse(obs)
        return response

    def reset(self, req):
        # Wait for the All Clear from emulator startup
        rospy.wait_for_message("/robot/sim/started", Empty)

        rand = self.np_random.uniform(-0.02, 0.02, size=7)
        sample2 = self.np_random.uniform(-0.1, 0.1, size=7)

        starting_joint_angles = {'left_w0': 0.6699952259595108 + rand[0],
                                'left_w1': 1.030009435085784 + rand[1],
                                'left_w2': -0.4999997247485215 + rand[2],
                                'left_e0': -1.189968899785275 + rand[3],
                                'left_e1': 1.9400238130755056 + rand[4],
                                'left_s0': -0.08000397926829805 + rand[5],
                                'left_s1': -0.9999781166910306+ rand[6]}
        
        self.move_to_start(starting_joint_angles)

        # An orientation for gripper fingers to be overhead and parallel to the obj
        # set to center if needed
        #self._approach(Pose(position=Point(x=0.35, y=0.5, z=-0.129), orientation=self.overhead_orientation))
        response = ResetResponse()
        return response
    
    def spawn_blocks(self, req ):
        
        b_p , block_reference_frame =  req.block_pose, req.block_reference_frame
        # b_p = [0.6725, 0.1265, 0.7825],
        # block_reference_frame = "world"
        block_pose = Pose(position=Point(x=b_p[0],y=b_p[1],z=0.7825))
        # Get Models' Path
        model_path = rospkg.RosPack().get_path('drl_project')+"/models/"
        # Load Block URDF
        block_xml = ''
        with open (model_path + "block/model.urdf", "r") as block_file:
            block_xml=block_file.read().replace('\n', '')

        # Spawn Block URDF
        rospy.wait_for_service('/gazebo/spawn_urdf_model')
        try:
            spawn_urdf = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
            resp_urdf = spawn_urdf("block", block_xml, "/",
                                block_pose, block_reference_frame)
        except rospy.ServiceException as e:
            rospy.logerr("Spawn URDF service call failed: {0}".format(e))

        response = SpawnBlocksResponse()
        return response

    def load_gazebo_models(self, req ):
        
        t_p, table_reference_frame, b_p, block_reference_frame = req.table_pose, req.table_reference_frame, \
                                                                    req.block_pose, req.block_reference_frame
        table_pose = Pose(position=Point(x=t_p[0],y=t_p[1],z=t_p[2]))
        block_pose = Pose(position=Point(x=b_p[0],y=b_p[1],z=b_p[2]))
        # Get Models' Path
        table_pose = Pose(position=Point(x=t_p[0], y=t_p[1], z=t_p[2]))
        model_path = rospkg.RosPack().get_path('drl_project')+"/models/"
        # Load Table SDF
        table_xml = ''
        with open (model_path + "cafe_table/model.sdf", "r") as table_file:
            table_xml=table_file.read().replace('\n', '')
        # Load Block URDF
        block_xml = ''
        with open (model_path + "block/model.urdf", "r") as block_file:
            block_xml=block_file.read().replace('\n', '')
        # Spawn Table SDF
        # rospy.wait_for_service('/gazebo/spawn_sdf_model')
        # try:
        #     spawn_sdf = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
        #     resp_sdf = spawn_sdf("cafe_table", table_xml, "/",
        #                         table_pose, table_reference_frame)
        # except rospy.ServiceException as e:
        #     rospy.logerr("Spawn SDF service call failed: {0}".format(e))
        # Spawn Block URDF
        rospy.wait_for_service('/gazebo/spawn_urdf_model')
        try:
            spawn_urdf = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
            resp_urdf = spawn_urdf("block", block_xml, "/",
                                block_pose, block_reference_frame)
        except rospy.ServiceException as e:
            rospy.logerr("Spawn URDF service call failed: {0}".format(e))
        
        response = LoadGazeboModelsResponse()
        return response

    def delete_gazebo_models(self, req):
        # This will be called on ROS Exit, deleting Gazebo models
        # Do not wait for the Gazebo Delete Model service, since
        # Gazebo should already be running. If the service is not
        # available since Gazebo has been killed, it is fine to error out
        OnlyBlocks = req.only_blocks
        try:
            delete_model = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
            if OnlyBlocks:
                resp_delete = delete_model("block")
            else:
                #resp_delete = delete_model("cafe_table")
                resp_delete = delete_model("block")
        except rospy.ServiceException as e:
            rospy.loginfo("Delete Model service call failed:ee {0}".format(e))
        
        response = DeleteGazeboModelsResponse()
        return response
    
    def clear(self):
        # This will be called on ROS Exit, deleting Gazebo models
        # Do not wait for the Gazebo Delete Model service, since
        # Gazebo should already be running. If the service is not
        # available since Gazebo has been killed, it is fine to error out

        try:
            delete_model = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
            #resp_delete = delete_model("cafe_table")
            resp_delete = delete_model("block")
        except rospy.ServiceException as e:
            rospy.loginfo("Delete Model service call failed:ee {0}".format(e))
        
        response = DeleteGazeboModelsResponse()
        return response

    def ls_callback(self, msg):
        # get object infor from gazebo
        gripper_l_finger = "baxter::l_gripper_l_finger"
        gripper_r_finger = "baxter::l_gripper_r_finger"
        block = "block::block"
        lf = 10
        rf = 11
        if block in msg.name:
            self.block_state = [msg.pose[-1].position, msg.pose[-1].orientation, msg.twist[-1].linear, msg.twist[-1].angular]
        else:
            self.block_state = []

    def move_to_start(self, start_angles=None):
        print("Moving the {0} arm to start pose...".format(self._limb_name))
        if not start_angles:
            start_angles = dict(zip(self._joint_names, [0]*7))
        self._guarded_move_to_joint_position(start_angles)
        self.gripper_open()
        # self._gripper.
        #rospy.sleep(1.0)
        print("Running. Ctrl-c to quit")

    def _guarded_move_to_joint_position(self, joint_angles):
        if joint_angles:
            self._limb.move_to_joint_positions(joint_angles)
        else:
            rospy.logerr("No Joint Angles provided for move_to_joint_positions. Staying put.")

    def gripper_open(self):
        self._gripper.open()
        rospy.sleep(1.0)

    def gripper_close(self):
        self._gripper.close()
        rospy.sleep(1.0)

    def _approach(self, pose):
        approach = copy.deepcopy(pose)
        # approach with a pose the hover-distance above the requested pose
        approach.position.z = approach.position.z + self._hover_distance
        joint_angles = self.ik_request(approach)
        self._guarded_move_to_joint_position(joint_angles)



def main():
    rospy.init_node("gazebo_conn")
    sim = Services("left")
    #rospy.on_shutdown(sim.clear)

    # services
    delete_gazebo_models = rospy.Service('delete_gazebo_models', DeleteGazeboModels, sim.delete_gazebo_models)
    get_obs_ = rospy.Service('get_obs', GetObs, sim.get_obs_)
    load_gazebo_models = rospy.Service('load_gazebo_models', LoadGazeboModels, sim.load_gazebo_models)
    reset = rospy.Service('reset', Reset, sim.reset)
    set_torque = rospy.Service('set_torque', SetTorque, sim.set_torque)
    spawn_blocks = rospy.Service('spawn_blocks', SpawnBlocks, sim.spawn_blocks)

    rospy.spin()


if __name__ == "__main__":
    main()