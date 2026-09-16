#include <Stepper.h>
const int stepsPerRevolution = 200; 
Stepper myStepper(stepsPerRevolution, 5, 6, 10, 11);
int motorSpeed = 100;
int threshold = 512;

void setup()
{
  myStepper.setSpeed(motorSpeed);
}

void loop()
{
  int inp = analogRead(A0);
  if(inp > threshold)
  {
    myStepper.step(20);
    delay(100);
    myStepper.step(-20);
    delay(100);
  }
  digitalWrite(5,LOW);
  digitalWrite(6,LOW);
  digitalWrite(10,LOW);
  digitalWrite(11,LOW);
}
