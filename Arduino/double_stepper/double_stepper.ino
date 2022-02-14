#include <Stepper.h>

// change this to the number of steps on your motor
#define STEPS1 100
#define STEPS2 100
// change this to the required speed
#define RPM1 100
#define RPM2 100
// change this to the number of rotations
#define NUM1 100
#define NUM2 100

Stepper stepper1(STEPS1, 8, 9, 10, 11);
Stepper stepper2(STEPS2, 2, 3, 5, 6);

void setup() {
  stepper1.setSpeed(RPM1);
  stepper2.setSpeed(RPM2);
}

void loop()
{
  int dir = 1;
  for(int i=0,s=0;i<NUM1*STEPS1;i++,s++)
  {
    stepper1.step(1);
    if(s % (NUM2*STEPS1) == 0)
    {
      dir = dir * -1;
      s = s / (NUM2*STEPS1);
    }
    else
      stepper2.step(dir);
  }
}
