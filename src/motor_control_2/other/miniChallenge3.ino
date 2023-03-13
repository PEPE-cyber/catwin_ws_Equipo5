#include <ros.h>
#include <std_msgs/Float32.h>

// Define the output pins
#define dirPin1 8
#define dirPin2 9
#define pwmPin  10

// Define the input pins
#define encoderPinA 2
#define encoderPinB 3


long previousTime = 0;
int pulses = 0;
float speed = 0;

// Function to get the speed
void encoderInterruptEncoder(){
  // Get the current time
  long currentTime = micros();
  // Calculate the time difference
  long timeDiff = currentTime - previousTime;
  // Calculate the speed (RPM)
  speed = 60000000.0 / (timeDiff * 11 * 35);
  // Update the previous time
  previousTime = currentTime;
  // Update the number of pulses depending on the direction
  if (digitalRead(encoderPinB) == LOW){
    pulses--;
  } else {
    pulses++;
  }
}


ros::NodeHandle  nh;

// Function callback for the subscriber (updates the pwm value)
void motorInputCb( const std_msgs::Float32& pwm_msg){
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

// Create the subscriber to motor_input topic
ros::Subscriber<std_msgs::Float32> sub("motor_input", pwmMsgCb);

// Create the message to publish
std_msgs::Float32 motor_output;
// Define the publisher
ros::Publisher pub("motor_output", &motor_output);


void setup()
{
  // Define the pins as output
  pinMode(dirPin1, OUTPUT);
  pinMode(dirPin2, OUTPUT);
  pinMode(pwmPin, OUTPUT);
  // Define the pins as input
  pinMode(encoderPinA, INPUT);
  pinMode(encoderPinB, INPUT);
  // Create an interrupt for the encoder
  attachInterrupt(digitalPinToInterrupt(encoderPinA), encoderInterruptEncoder, RISING);
  // Initialize the node
  nh.initNode();
  // Create a publisher
  nh.advertise(pub);
  // Subscribe to the topic
  nh.subscribe(sub);
}

const int samplingPeriod = 100; // 100ms
long previousMillis = 0;
long currentMillis = 0;

void loop()
{
  currentMillis = millis();
  // If the sampling period has passed, publish the speed
  if (currentMillis - previousMillis > samplingPeriod) {
    previousMillis = currentMillis;
    motor_output.data = speed;
    pub.publish(&motor_output); 
  }
  nh.spinOnce();
  delay(1);
}