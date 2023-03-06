#!/usr/bin/env python2
import rospy
import numpy as np
from std_msgs.msg import Float32




#Stop Condition
def stop():
 #Setup the stop message (can be the same as the control message)
  print("Stopping")

class InputGenerator:
    def __init__(self):
        self.freq = rospy.get_param("/frequency")
        self.amplitud = rospy.get_param("/amplitude")
        self.signal = rospy.get_param("/signal_type")
        self.pwmPub = rospy.Publisher("cmd_pwm", Float32, queue_size=10)
        self.pwmValue = 0.0
        self.time =  rospy.get_time()
        self.prevTime = rospy.get_time()

    def run(self):
        self.time =  rospy.get_time()
        # step, square, sinusoidal
        if self.signal == "sinusoidal": 
            self.pwmValue = self.amp * (np.sin(2 * np.pi * self.freq * rospy.get_time())) 
        elif self.signal == "square": 
            if rospy.get_time() - self.prevTime > ( 1 / self.freq):
                if self.pwmValue > 0:
                    self.pwmValue = 0
                else:
                    self.pwmValue =  self.amp
                self.prevTime = rospy.get_time()
        else: # step
            if rospy.get_time() < self.time + 5:
                self.pwmValue = 0
            else:
                self.pwmValue = self.amplitud
        self.pwmPub.publish(self.pwmValue)

    def stop(self):
        print("Stopping")

if __name__=='__main__':
    #Initialise and Setup node
    rospy.init_node("Input")
    rate = rospy.Rate(100)
    rospy.on_shutdown(stop)
    input = InputGenerator()
    print("Input Genertor is Running")

    #Run the node
    while not rospy.is_shutdown():
        input.run()
        #Write your code here
        rate.sleep()