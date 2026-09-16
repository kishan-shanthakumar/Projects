char data = 0;
char data1 = 0;
void setup()
{
  Serial.begin(38400);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(9, OUTPUT);
}
void loop()
{
  if(Serial.available() > 0)
  {
    data = Serial.read();
    Serial.print(data);
    Serial.print("\n");
    if(data == '+')
      digitalWrite(12, HIGH);
    else if(data == '0')
      digitalWrite(12, LOW);
    else if(data == '1')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<600;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
    else if(data == '2')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<1200;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
    else if(data == '3')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<1800;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
    else if(data == '4')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<2400;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
    else if(data == '5')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<3000;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
    else if(data == 'a')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<3600;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
    else if(data == 'b')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<7200;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
    else if(data == 'c')
    {
      digitalWrite(12, HIGH);
      for(int i=0;i<10800;i++)
      {
        delay(1000);
        if(Serial.available())
        {
          data1=Serial.read();
          if(data1='0')
          {
            digitalWrite(12,LOW);
            break;
          }
        }
      }
      digitalWrite(12,LOW);
    }
  }
}
