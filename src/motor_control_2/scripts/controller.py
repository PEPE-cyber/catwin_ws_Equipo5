#!/usr/bin/env python
import rospy
from motor_control_2.msg import motor_output
from motor_control_2.msg import motor_input 
from motor_control_2.msg import set_point
from std_msgs.msg import Float32

#Setup parameters, vriables and callback functions here (if required)

class PIDController:
    def __init__(self):
        # get parameters from parameter server
        self.kp = rospy.get_param("/kp")
        self.ki = rospy.get_param("/ki")
        self.kd = rospy.get_param("/kd")
        # initialise variables
        self.setpoint = 0.0

        self.error = 0.0
        self.error_sum = 0.0
        self.error_diff = 0.0
        self.prev_error = 0.0
        self.prev_time = 0.0
        self.controllerOutput = motor_input()
        self.prev_output = 0.0
        # setup publishers and subscribers
        self.motorInputPub = rospy.Publisher("/motor_input", motor_input, queue_size=10)
        self.motorOutputSub = rospy.Subscriber("/motor_output", motor_output, self.updateFromMotorOutput, queue_size=10)
        self.setpointSub = rospy.Subscriber("/set_point", set_point, self.updateSetpoint, queue_size=10)
        print("Controller Initialised")
        print("kp: " + str(self.kp) + " ki: " + str(self.ki) + " kd: " + str(self.kd))

    
    def updateFromMotorOutput(self, output):
        # Check if this is the first time we have received a message
        if self.prev_time != 0:
            # Calculate the dt, error, error_sum (integral) and error_diff (derivative)
            # The dt is the time difference between messages
            dt = output.time - self.prev_time
            # Update the previous time for the next iteration
            self.prev_time = output.time
            # Calculate the error (difference between the setpoint and the output of the motor)
            self.error = self.setpoint - output.output 
            # Calculate the error_sum (integral) with trapezoidal integration
            self.error_sum += (self.error + self.prev_error) * dt / 2
            # Calculate the error_diff (derivative) (actual error - previous error divided by dt)
            self.error_diff = (self.error - self.prev_error) / dt
            # Update the previous error for the next iteration
            self.prev_error = self.error
        else:
            self.prev_time = output.time
        #print("setpoint", self.setpoint, "MotorOutput",  output.output, "Error", self.error, "MotorInput", self.controllerOutput.value)

    def get_output(self):
        # Calculate the output of the controller
        pidOutput = self.kp * self.error + self.ki * self.error_sum + self.kd * self.error_diff
        # Range limit the output of the controller
        if pidOutput > 1:
            pidOutput = 1
        elif pidOutput < -1:
            pidOutput = -1
        # Set the output of the controller (motor_input)
        self.controllerOutput.value = pidOutput
        self.controllerOutput.time = rospy.get_time()
        return self.controllerOutput
    
    def run(self):
        # Check if the output has been updated
        if self.prev_output != self.controllerOutput.value:
            # Update the previous output for the next iteration
            self.prev_output = self.controllerOutput.value
            # Publish the output of the controller
            self.motorInputPub.publish(controller.get_output())
  
    def stop(self):
        print("Stopping")

    def updateSetpoint(self, setpoint):
        self.setpoint = setpoint.value
        #print("Setpoint Updated to: " + str(self.setpoint) + " at time: " + str(setpoint.time) )

if __name__=='__main__':
    #Initialise and Setup node
    rospy.init_node("controller")

    rate = rospy.Rate(100)
    controller = PIDController()
    rospy.on_shutdown(controller.stop)
    errorPub = rospy.Publisher("/error", Float32, queue_size=10)
    #Setup Publishers and subscribers here
    
    
                          
    print("The Controller is Running")
    #Run the node
    while not rospy.is_shutdown():
        controller.run()
        errorPub.publish(controller.error)
        rate.sleep()

