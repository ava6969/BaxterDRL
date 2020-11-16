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
    TransformStamped
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
                            SpawnBlocks, SpawnBlocksResponse,
                            LoadGazeboModelsWithTarget, LoadGazeboModelsWithTargetResponse,
                            DeleteGazeboModelsWithTarget, DeleteGazeboModelsWithTargetResponse,
                            Logger, LoggerResponse,
                            SpawnBlocksWithTarget, SpawnBlocksWithTargetResponse  )



class PNPServices():
    def __init__(self, limb, hover_distance = 0.15, verbose=True):
        self._limb_name = limb # string
        self._hover_distance = hover_distance # in meters
        self._verbose = verbose # bool
    
        self._limb = baxter_interface.Limb(limb)
      
        self._gripper = baxter_interface.Gripper(limb)
    
        self.init_obj_pose = []
        self.link_states_sub = rospy.Subscriber("/gazebo/link_states", LinkStates, self.link_state_callback)
        self.log_pub = rospy.Publisher("/logger",queue_size=5)
        ns = "ExternalTools/" + limb + "/PositionKinematicsNode/IKService"
        self._iksvc = rospy.ServiceProxy(ns, SolvePositionIK)
        rospy.wait_for_service(ns, 5.0)
        # verify robot is enabled
        print("Getting robot state... ")
        self._rs = baxter_interface.RobotEnable(baxter_interface.CHECK_VERSION)
        self._init_state = self._rs.state().enabled
        print("Enabling robot... ")
        self._rs.enable()
        self.block_state = []
        self.overhead_orientation = Quaternion(
                        x=-0.0249590815779,
                        y=0.999649402929,
                        z=0.00737916180073,
                        w=0.00486450832011)
        
        self.np_random = np.random.RandomState()
        
        self.l_finger_pose = []
        self.r_finger_pose = []
        self.obj_pose = []

    def logger(self, req):
        msg = req.msg
        additional_msg = f"left finger_pose: {self.l_finger_pose}\n" + \
                         f"right finger pose: {self.r_finger_pose}\n" + \
                         f"object pose: {self.obj_pose}\n" + \
                         f"gripper position: {self._gripper.position()}\n"
        self.log_pub.publish(msg + additional_msg)

    def link_state_callback(self, msg):
        lf = 10
        rf = 11
        self.l_finger_pose = [msg.pose[lf].position.x, msg.pose[lf].position.y, msg.pose[lf].position.z]
        self.r_finger_pose = [msg.pose[rf].position.x, msg.pose[rf].position.y, msg.pose[rf].position.z]
        t_block = "target_block::block"
        if t_block in msg.name:
            self.obj_pose = [msg.pose[-1].position.x, msg.pose[-1].position.y, msg.pose[-1].position.z]
        else:
            self.obj_pose = self.init_obj_pose

    def set_torque(self, req):

        t_actions, g_actions = req.t_value, req.g_value
        torque_dict = {k:v for k, v in zip(self._limb.joint_names(), t_actions)}
        
        self._limb.set_joint_torques(torque_dict)
        self._gripper.command_position(g_actions)
        # print('g_actio:',g_actions)
        # print('g_pos',self._gripper.position() )
        response = SetTorqueResponse()

        return response

    def get_obs_(self, req):
        obs = []
        obs.extend(self._limb.joint_angles().values()) # "j_angle"
        obs.extend(self._limb.joint_velocities().values()) # j_vel
        ee = self._limb.endpoint_pose()["position"]
        obs.extend([ee.x, ee.y, ee.z]) # ee_p
        obs.append(self._gripper.position() / 100) # gripper_pos
        obs.extend(self.l_finger_pose)
        obs.extend(self.r_finger_pose)
        obs.extend(self.obj_pose)
        #print(self._gripper.position() )
        
        response = GetObsResponse(obs)
        return response

    def reset(self, req):
        # Wait for the All Clear from emulator startup
        rospy.wait_for_message("/robot/sim/started", Empty)

        rand = self.np_random.uniform(-0.02, 0.02, size=7)
 
        starting_joint_angles = {'left_w0': 1.75 + rand[0],
                                'left_w1': 1.50 + rand[1],
                                'left_w2': -0.4999997247485215 + rand[2],
                                'left_e0': -1.5 + rand[3],
                                'left_e1': 1.5 + rand[4],
                                'left_s0': -0.3 + rand[5],
                                'left_s1': 0 + rand[6]}
        
        self.move_to_start(starting_joint_angles)

        response = ResetResponse()
        return response
    
    def spawn_blocks_t(self, req):

        b_p , block_reference_frame =  req.block_pose, req.block_reference_frame
        
        block_pose = Pose(position=Point(x=b_p[0],y=b_p[1],z=0.7825 + 0.3))
        target_pose = Pose(position=Point(x=b_p[0],y=b_p[1],z=0.7825))
        self.init_obj_pose = [b_p[0], b_p[1], 0.7825]
   
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
            spawn_urdf("goal_block", block_xml, "/", block_pose, block_reference_frame)
        except rospy.ServiceException as e:
            rospy.logerr("Spawn URDF service call failed: {0}".format(e))


        
        target_xml = ''
        # Load Target Block
        with open(model_path + "block/target.urdf", "r") as target_file:
            target_xml = target_file.read().replace('\n', '')
        # Spawn target URDF
        rospy.wait_for_service('/gazebo/spawn_urdf_model')
        try:
            spawn_urdf = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
            spawn_urdf("target_block", target_xml, "/", target_pose, block_reference_frame)
        except rospy.ServiceException as e:
            rospy.logerr("Spawn URDF Service call failed {0}".format(e))
        
        response = SpawnBlocksWithTargetResponse()
        return response

    def load_gazebo_models_t(self, req ):
  
        t_p, table_reference_frame, b_p, block_reference_frame = req.table_pose, req.table_reference_frame, \
                                                                    req.block_pose, req.block_reference_frame
    
        block_pose = Pose(position=Point(x=b_p[0],y=b_p[1],z=0.7825 + 0.3))
        table_pose = Pose(position=Point(x=t_p[0],y=t_p[1],z=t_p[2]))
        target_pose= Pose(position=Point(x=b_p[0],y=b_p[1],z=0.7825))

        self.init_obj_pose = [b_p[0], b_p[1], 0.7825]

        # Get Models' Path
        model_path = rospkg.RosPack().get_path('drl_project')+"/models/"
        # Load Table SDF
        table_xml = ''
        with open (model_path + "cafe_table/model.sdf", "r") as table_file:
            table_xml=table_file.read().replace('\n', '')
        # Load Block URDF
        block_xml = ''
        with open (model_path + "block/model.urdf", "r") as block_file:
            block_xml=block_file.read().replace('\n', '')
        # Load Target Block
        with open(model_path + "block/target.urdf", "r") as target_file:
            target_xml = target_file.read().replace('\n', '')
        
        # Spawn Table SDF
        rospy.wait_for_service('/gazebo/spawn_sdf_model')
        try:
            spawn_sdf = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
            spawn_sdf("cafe_table", table_xml, "/",
                                table_pose, table_reference_frame)
        except rospy.ServiceException as e:
            rospy.logerr("Spawn SDF service call failed: {0}".format(e))
        # Spawn Block URDF
        rospy.wait_for_service('/gazebo/spawn_urdf_model')
        try:
            spawn_urdf = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
            spawn_urdf("goal_block", block_xml, "/",
                                block_pose, block_reference_frame)
        except rospy.ServiceException as e:
            rospy.logerr("Spawn URDF service call failed: {0}".format(e))
        # Spawn target URDF
        rospy.wait_for_service('/gazebo/spawn_urdf_model')
        try:
            spawn_urdf = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
            spawn_urdf("target_block", target_xml, "/", target_pose, block_reference_frame)
        except rospy.ServiceException as e:
            rospy.logerr("Spawn URDF Service call failed {0}".format(e))


        response = LoadGazeboModelsWithTargetResponse()
        return response

    def delete_gazebo_models_t(self, req):
        # This will be called on ROS Exit, deleting Gazebo models
        # Do not wait for the Gazebo Delete Model service, since
        # Gazebo should already be running. If the service is not
        # available since Gazebo has been killed, it is fine to error out
        OnlyBlocks = req.only_blocks

        try:
            delete_model = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
            if OnlyBlocks:
                delete_model("target_block")
                delete_model("goal_block")
            else:
                delete_model("cafe_table")
                delete_model("goal_block")
                delete_model("target_block")
        except rospy.ServiceException as e:
            rospy.loginfo("Delete Model service call failed:ee {0}".format(e))
        
        response = DeleteGazeboModelsWithTargetResponse()
        return response

    def move_to_start(self, start_angles=None):
        print("Moving the {0} arm to start pose...".format(self._limb_name))
        if not start_angles:
            start_angles = dict(zip(self._joint_names, [0]*7))
        self._guarded_move_to_joint_position(start_angles)
        self.gripper_open()
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


def main():
    rospy.init_node("gazebo_conn_pnp")
    sim = PNPServices("left")
    # services
    delete_gazebo_models_t = rospy.Service('delete_gazebo_models_t', DeleteGazeboModelsWithTarget, sim.delete_gazebo_models_t)
    get_obs = rospy.Service('get_obs_t', GetObs, sim.get_obs_)
    load_gazebo_models_t = rospy.Service('load_gazebo_models_t', LoadGazeboModelsWithTarget, sim.load_gazebo_models_t)
    reset = rospy.Service('reset_t', Reset, sim.reset)
    set_torque = rospy.Service('set_torque_t', SetTorque, sim.set_torque)
    spawn_blocks_t = rospy.Service('spawn_blocks_t', SpawnBlocksWithTarget, sim.spawn_blocks_t)
    rospy.spin()


if __name__ == "__main__":
    main()