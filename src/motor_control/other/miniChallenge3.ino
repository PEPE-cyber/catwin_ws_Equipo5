#include <ros.h>
#include <std_msgs/Float32.h>

#define dirPin1 8
#define dirPin2 9
#define pwmPin  10

ros::NodeHandle  nh;

// Function callback for the subscriber (updates the pwm value)
void pwmMsgCb( const std_msgs::Float32& pwm_msg){
  // Get the pwm value from the message
  float receivedValue = pwm_msg.data; 
  // Map the value to the range 0-255
  int pwmValue = map(abs(receivedValue), 0, 100, 0, 255);
  // Set the value to the pwm pin
  analogWrite(pwmPin, pwmValue);
  // Set the direction of the motor
  if (receivedValue < 0){
    digitalWrite(dirPin1, HIGH);
    digitalWrite(dirPin2, LOW);
  } else {
    digitalWrite(dirPin1, LOW);
    digitalWrite(dirPin2, HIGH);
  } 
  
}

// Create the subscriber to cmd_pwm topic
ros::Subscriber<std_msgs::Float32> sub("cmd_pwm", pwmMsgCb);


void setup()
{
  // Define the pins as output
  pinMode(dirPin1, OUTPUT);
  pinMode(dirPin2, OUTPUT);
  pinMode(pwmPin, OUTPUT);
  // Initialize the node
  nh.initNode();
  // Subscribe to the topic
  nh.subscribe(sub);
}

void loop()
{
  nh.spinOnce();
  delay(1);
}