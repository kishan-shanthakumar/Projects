String a;
void setup()
{
  Serial.begin(38400);
  pinMode(9,OUTPUT);
}

void loop()
{
  while(Serial.available())
  {
    a=Serial.readString();
    Serial.println(a);
    if(a=="+")
    {
      digitalWrite(9,HIGH);
    }
    else
    {
      int t=a.toInt();
      int h=t/10000;
      int m=(t/100)%100;
      int s=t%100;
      int fin=h*3600+m*60+s;
      for(int i=0;i<fin;i++)
      {
        if(Serial.available())
        {
          String temp=Serial.readString();
          digitalWrite(9,LOW);
          break;
        }
        digitalWrite(9,HIGH);
        delay(1000);
      }
      digitalWrite(9,LOW);
    }
  }
}
