#include<Servo.h>

Servo myservo;

void setup()
{
  myservo.attach(9);
  myservo.write(90);
}

void loop()
{
  int a = analogRead(A0);

  if (a < 250)
  {
    myservo.write(130);
    delay(300);
    myservo.write(90);
    delay(150);
  }
}
