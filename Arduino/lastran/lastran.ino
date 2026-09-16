void setup()
{
  pinMode(2,INPUT);
  pinMode(3,OUTPUT);
}

void loop()
{
  if(digitalRead(2)==LOW)
  {
    digitalWrite(3,HIGH);
    delay(1000);
  }
}
