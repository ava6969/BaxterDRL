#!/usr/bin/env python2

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

class GazeboConnection():
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

    def set_torque_actions(self, t_actions, g_actions):

        torque_dict = {k:v for k, v in zip(self._limb._joint_names, t_actions)}
        self._limb.set_joint_torques(torque_dict)
        self._gripper.command_position(g_actions*100)
        rospy.sleep(1)

    def get_obs_(self):
        
        obs = {}
        obs["j_angle"]  = self._limb.joint_angles().values()
        obs["j_vel"] =  self._limb.joint_velocities().values()
        obs["ee_p"] = self._limb.endpoint_pose().values
        #print("ep vel", self._limb.endpoint_velocity()) provide velocities as state to see if it imporves
        obs["g_pos"] = self._gripper.position() / 100

        return obs

    def step(self):
        """
        define what step really means in terms of time steps and execuation in gazebo
        """
        pass
        

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
        rospy.sleep(1.0)
        print("Running. Ctrl-c to quit")
    def _guarded_move_to_joint_position(self, joint_angles):
        if joint_angles:
            self._limb.move_to_joint_positions(joint_angles)
        else:
            rospy.logerr("No Joint Angles provided for move_to_joint_positions. Staying put.")
    def gripper_open(self):
        self._gripper.open()
        rospy.sleep(1.0)
    
    def ik_request(self, pose):
        hdr = Header(stamp=rospy.Time.now(), frame_id='base')
        ikreq = SolvePositionIKRequest()
        ikreq.pose_stamp.append(PoseStamped(header=hdr, pose=pose))
        try:
            resp = self._iksvc(ikreq)
        except (rospy.ServiceException, rospy.ROSException), e:
            rospy.logerr("Service call failed: %s" % (e,))
            return False
        # Check if result valid, and type of seed ultimately used to get solution
        # convert rospy's string representation of uint8[]'s to int's
        resp_seeds = struct.unpack('<%dB' % len(resp.result_type), resp.result_type)
        limb_joints = {}
        if (resp_seeds[0] != resp.RESULT_INVALID):
            seed_str = {
                        ikreq.SEED_USER: 'User Provided Seed',
                        ikreq.SEED_CURRENT: 'Current Joint Angles',
                        ikreq.SEED_NS_MAP: 'Nullspace Setpoints',
                       }.get(resp_seeds[0], 'None')
            if self._verbose:
                print("IK Solution SUCCESS - Valid Joint Solution Found from Seed Type: {0}".format(
                         (seed_str)))
            # Format solution into Limb API-compatible dictionary
            limb_joints = dict(zip(resp.joints[0].name, resp.joints[0].position))
            if self._verbose:
                print("IK Joint Solution:\n{0}".format(limb_joints))
                print("------------------")
        else:
            rospy.logerr("INVALID POSE - No Valid Joint Solution Found.")
            return False
        return limb_joints

    def gripper_close(self):
        self._gripper.close()
        rospy.sleep(1.0)

    def set_action(self, action):
        x, y, grip_dist = action
        self._approach(Pose(position=Point(x=x, y=y, z=-0.129), orientation=overhead_orientation))
        self._gripper.command_position(position=float(grip_dist)*100.0)
        rospy.sleep(1)

    def _approach(self, pose):
        approach = copy.deepcopy(pose)
        # approach with a pose the hover-distance above the requested pose
        approach.position.z = approach.position.z + self._hover_distance
        joint_angles = self.ik_request(approach)
        self._guarded_move_to_joint_position(joint_angles)

    def reset(self):
        # Wait for the All Clear from emulator startup
        rospy.wait_for_message("/robot/sim/started", Empty)

        starting_joint_angles = {'left_w0': 0.6699952259595108,
                                'left_w1': 1.030009435085784,
                                'left_w2': -0.4999997247485215,
                                'left_e0': -1.189968899785275,
                                'left_e1': 1.9400238130755056,
                                'left_s0': -0.08000397926829805,
                                'left_s1': -0.9999781166910306}
        self.move_to_start(starting_joint_angles)

        # An orientation for gripper fingers to be overhead and parallel to the obj

        self._approach(Pose(position=Point(x=0.35, y=0.5, z=-0.129), orientation=self.overhead_orientation))
    
    def load_gazebo_models(self,table_pose=Pose(position=Point(x=0.75, y=0.5, z=0.0)),
                    table_reference_frame="world",
                    block_pose=Pose(position=Point(x=0.6725, y=0.1265, z=0.7825)),
                    block_reference_frame="world"):

        # Get Models' Path
        model_path = rospkg.RosPack().get_path('baxter_sim_examples')+"/models/"
        # Load Table SDF
        table_xml = ''
        with open (model_path + "cafe_table/model.sdf", "r") as table_file:
            table_xml=table_file.read().replace('\n', '')
        # Load Block URDF
        block_xml = ''
        with open (model_path + "block/model.urdf", "r") as block_file:
            block_xml=block_file.read().replace('\n', '')
        # Spawn Table SDF
        rospy.wait_for_service('/gazebo/spawn_sdf_model')
        try:
            spawn_sdf = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
            resp_sdf = spawn_sdf("cafe_table", table_xml, "/",
                                table_pose, table_reference_frame)
        except rospy.ServiceException, e:
            rospy.logerr("Spawn SDF service call failed: {0}".format(e))
        # Spawn Block URDF
        rospy.wait_for_service('/gazebo/spawn_urdf_model')
        try:
            spawn_urdf = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
            resp_urdf = spawn_urdf("block", block_xml, "/",
                                block_pose, block_reference_frame)
        except rospy.ServiceException, e:
            rospy.logerr("Spawn URDF service call failed: {0}".format(e))

    def delete_gazebo_models(self):
        # This will be called on ROS Exit, deleting Gazebo models
        # Do not wait for the Gazebo Delete Model service, since
        # Gazebo should already be running. If the service is not
        # available since Gazebo has been killed, it is fine to error out
        try:
            delete_model = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
            resp_delete = delete_model("cafe_table")
            resp_delete = delete_model("block")
        except rospy.ServiceException, e:
            rospy.loginfo("Delete Model service call failed: {0}".format(e))

def test():
    rospy.init_node("gazebo_conn")
    # Wait for the All Clear from emulator startup
    limb = 'left'
    hover_distance = 0.15 # meters
    sim = GazeboConnection(limb, hover_distance=hover_distance)
    # sim.load_gazebo_models()
    # # Remove models from the scene on shutdown
    # rospy.on_shutdown(sim.delete_gazebo_models)
    # sim.reset()

    
    while not rospy.is_shutdown():
        # pose = Pose(position=Point(x=random.uniform(0.80, 0.40) , y=random.uniform(0.5, 0.2), z=-0.129))
        # sim._approach(pose)
        print(sim._limb._joint_angle)
        # x = input("enter ratio")
        # sim._gripper.command_position(position=float(x)*100.0)
        pass


if __name__ == "__main__":
    test()