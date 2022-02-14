float a=0;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  a=analogRead(A0);
  Serial.println(a);
  a=a-511;
  if(a<0)
  {
    analogWrite(5,(-a)*2);
    analogWrite(6,0);
  }
  else if(a>0)
  {
    analogWrite(5,0);
    analogWrite(6,a*2);
  }
  else
  {
    digitalWrite(5,LOW);
    digitalWrite(6,LOW);
  }
}
