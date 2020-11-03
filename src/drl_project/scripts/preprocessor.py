#!/usr/bin/env python
import rospy
from gazebo_msgs.msg import LinkStates
from sensor_msgs.msg import JointState
import numpy as np

class Preprocessor:
    
    def __init__(self):
        self.js_sub = rospy.Subscriber("/robot/joint_states", JointState, self.js_callback)
        self.obj_sub = rospy.Subscriber("/gazebo/link_states", LinkStates, self.ls_callback)
        self.state_pub = rospy.Publisher("/preproc", JointState,queue_size=10)
        self.joint_state = []
        self.object_state = []

    def js_callback(self, msg:JointState):
        s = []
        s.extend(msg.position)
        s.extend(msg.velocity)
        self.joint_state.position = s
        
    def ls_callback(self, msg:LinkStates):
        # hardcoded for now - target and object pose and twist
        # 
        # @todo: make code neater
        obj_state = [msg.pose[-2].position, msg.pose[-2].orientation, msg.twist[-2].linear, msg.twist[-2].angular]
        obj_state.extend([msg.pose[-1].position, msg.pose[-1].orientation, msg.twist[-1].linear, msg.twist[-1].angular])

        # get gripper position, distance between fingers, linear velocity of gripper and fingers 
        # get valid target points so gym can select randomly
        # relative position of target and object. linear and angular velocity of objects

        concated = []
        for state in obj_state:
            concated.append(state.x)
            concated.append(state.y)
            concated.append(state.z)

            if isinstance(state, type(msg.pose[-2].orientation)):
                concated.append(state.w)
    
        self.object_state = concated

    def server(self):

        while not rospy.is_shutdown():
            js = JointState()
            js.position = [self.joint_state, self.object_state]
            self.state_pub.publish(js)
            # maybe sleep


if __name__ == '__main__':
    rospy.init_node('preprocessor', anonymous=True)
    Preprocessor()
    rospy.spin()

