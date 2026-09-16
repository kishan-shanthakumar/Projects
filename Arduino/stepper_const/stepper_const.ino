#include <Stepper.h>
int stepsPerRevolution = 200; 
Stepper myStepper(stepsPerRevolution, 5, 6, 10, 11);
int motorSpeed = 135;
void setup()
{
  Serial.begin(2000000);
}

void loop()
{
  int tim=millis();
  while(millis()-tim<10)
  {
    myStepper.setSpeed(motorSpeed);
    myStepper.step(stepsPerRevolution / 100);
    Serial.println(motorSpeed);
  }
  if(motorSpeed<135)
    motorSpeed+=1;
}
