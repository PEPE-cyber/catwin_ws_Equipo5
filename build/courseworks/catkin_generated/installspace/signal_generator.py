#!/usr/bin/env python2
from math import sin
import rospy
from std_msgs.msg import Float32

if __name__ == '__main__':
  # Create a publisher for the signal and time
  signalPub = rospy.Publisher("signal", Float32, queue_size=10)
  timePub = rospy.Publisher("time", Float32, queue_size=10)
  
  # Initialize the node
  rospy.init_node("signal_generator")

  rate = rospy.Rate(10)

  while not rospy.is_shutdown():
    time = rospy.get_time()
    timePub.publish(time)

    signal = sin(time)
    signalPub.publish(signal)
    
    rospy.loginfo("Time: %f, Signal: %f", time, signal)

    rate.sleep()
