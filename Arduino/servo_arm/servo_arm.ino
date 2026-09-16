#include <Servo.h>

Servo base,gripper,p1,p2,p3;
int pa0,pa1,pa2,pa3,a0,a1,a2,a3;

void setup()
{
  base.attach(3);
  p1.attach(5);
  p2.attach(6);
  p3.attach(9);
  gripper.attach(10);
  base.write(70);
  p1.write(100);
  p2.write(0);
  p3.write(0);
  gripper.write(70);
  Serial.begin(9600);
  pa0 = map(analogRead(A0),0,1024,0,180);
  pa1 = map(analogRead(A1),0,1024,0,180);
  pa2 = map(analogRead(A2),0,1024,0,180);
  pa3 = map(analogRead(A3),0,1024,0,180);
}

void loop()
{
  
  a0 = map(analogRead(A0),0,1024,0,180);
  a1 = map(analogRead(A1),0,1024,0,180);
  a2 = map(analogRead(A2),0,1024,0,180);
  a3 = map(analogRead(A3),0,1024,0,180);
  Serial.print(a0);
  Serial.print("  ");
  Serial.print(a1);
  Serial.print("  ");
  Serial.print(a2);
  Serial.print("  ");
  Serial.println(a3);
  if(!(abs(pa0-a0)<5 && abs(pa1-a1)<5 && abs(pa2-a2)<5 && abs(pa3-a3)<5))
  {
    gripper.write(70);
    pa0=a0;
    pa1=a1;
    pa2=a2;
    pa3=a3;
  }
  base.write(pa0);
  p1.write(pa1);
  p2.write(pa2);
  p3.write(pa3);
  delay(1000);
}
