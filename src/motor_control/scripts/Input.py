#!/usr/bin/env python
import rospy
import numpy as np
from std_msgs.msg import Float32




#Stop Condition
def stop():
 #Setup the stop message (can be the same as the control message)
  print("Stopping")

class InputGenerator:
    def __init__(self):
        # Get the parameters from the launch file
        self.freq = rospy.get_param("/frequency")
        self.amplitude = rospy.get_param("/amplitude")
        self.signal = rospy.get_param("/signal_type")
        # Setup the publisher on the cmd_pwm topic
        self.pwmPub = rospy.Publisher("cmd_pwm", Float32, queue_size=10)
        # Setup the pwm value
        self.pwmValue = 0.0
        # Setup the time and previous time
        self.time =  rospy.get_time()
        self.prevTime = rospy.get_time()

    def run(self):
        # Get the current time
        self.time =  rospy.get_time()
        # Determine the signal type
        if self.signal == "sinusoidal": 
            # Calculate the pwm value with a sinusoidal function
            self.pwmValue = self.amplitude * (np.sin(2 * np.pi * self.freq * rospy.get_time())) 
        elif self.signal == "square": 
            # Calculate the pwm value with a square function
            # Check if the time is greater than the previous time + 1/freq (the period). If it is, change the pwm value
            if rospy.get_time() - self.prevTime > ( 1 / self.freq):
                # If the pwm value is positive, make it negative and vice versa
                if self.pwmValue > 0:
                    self.pwmValue = -self.amplitude
                else:
                    self.pwmValue =  self.amplitude
                # Update the previous time for the next period
                self.prevTime = rospy.get_time()
        else: 
            # Calculate the pwm value with a rectangular function
            # Check if the time is less than the previous time + 5 seconds. If it is, set the pwm value to 0
            if rospy.get_time() < (self.prevTime + 5):
                self.pwmValue = 0
            # If the time has passed, set the pwm value to the amplitude (start the step)
            else:
                self.pwmValue = self.amplitude
        # Publish the pwm value
        self.pwmPub.publish(self.pwmValue)

    def stop(self):
        # Stop the motor (publish 0)
        self.pwmPub.publish(0)
        print("Stopping motor")

if __name__=='__main__':
    #Initialise and Setup node
    rospy.init_node("Input")
    # Set the rate of the node
    rate = rospy.Rate(100)
    # Create an instance of the InputGenerator class
    input = InputGenerator()
    print("Input Genertor is Running")
    # Setup the shutdown function to stop the motor
    rospy.on_shutdown(input.stop)

    #Run the node
    while not rospy.is_shutdown():
        # Run the input generator (publish the pwm value)
        input.run()
        #Write your code here
        rate.sleep()