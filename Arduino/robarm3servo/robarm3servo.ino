#include<Servo.h>
Servo myservo1;
Servo myservo2;
Servo myservo3;
Servo myservo4;
int pos1=0;
int pos2=0;
int pos3=0;
int pos4=75;
void setup()
{
  myservo1.attach(8);
  myservo2.attach(9);
  myservo3.attach(10);
  myservo3.attach(11);  
}
void loop()
{
  if(analogRead(A0)<300)
  {
    if(pos1>0)
      pos1--;
  }
  if(analogRead(A0)>700)
  {
    if(pos1<180)
      pos1++;
  }
  if(analogRead(A1)<300)
  {
    if(pos2>0)
      pos2--;
  }
  if(analogRead(A1)>700)
  {
    if(pos2<180)
      pos2++;
  }
  if(analogRead(A2)<300)
  {
    if(pos3>0)
      pos3--;
  }
  if(analogRead(A2)>700)
  {
    if(pos3<180)
      pos3++;
  }
  if(analogRead(A3)<300)
  {
    if(pos4>55)
      pos4--;
  }
  if(analogRead(A3)>700)
  {
    if(pos4<90)
      pos4++;
  }
  myservo1.write(pos1);
  myservo2.write(pos2);
  myservo3.write(pos3);
  myservo4.write(pos4);
}
