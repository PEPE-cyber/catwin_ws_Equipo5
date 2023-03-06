#!/usr/bin/env python2
import rospy
from std_msgs.msg import Float32
from math import sqrt, sin, cos

SIGNAL_PHASESHIFT = .5

processedSignal = 0
prevSinValue = 0


def signalCallback(msg):
  recivedSignal = msg.data
  global processedSignal
  global prevSinValue
  if recivedSignal < prevSinValue:
    cosOfX =  - sqrt(1 - recivedSignal**2)
  else :
    cosOfX = sqrt(1 - recivedSignal**2)
  prevSinValue = recivedSignal
  processedSignal = ((recivedSignal * cos(SIGNAL_PHASESHIFT) + cosOfX * sin(SIGNAL_PHASESHIFT)) + 1) / 2
  rospy.loginfo("Processed Signal: %f", processedSignal)


def timeCallback(msg):
  recivedTime = msg.data
  rospy.loginfo("Time: %f", recivedTime)

if __name__ == '__main__':
  processedSignalPub = rospy.Publisher("proc_signal", Float32, queue_size=10)
  rospy.Subscriber("signal", Float32, signalCallback)
  rospy.Subscriber("time", Float32)
  rospy.init_node("process")
  rate = rospy.Rate(10)
  while not rospy.is_shutdown():
    processedSignalPub.publish(processedSignal)
    rate.sleep()