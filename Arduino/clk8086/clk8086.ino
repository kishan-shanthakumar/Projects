void setup()
{
  pinMode(3,OUTPUT);
}

void loop()
{
  digitalWrite(3,HIGH);
  
  digitalWrite(3,LOW);
  delayMicroseconds(3);
}
