void setup()
{
  Serial.begin(9600);
}
void loop()
{
  
}
void test(int opt)
{
  if(opt==1)
  {
    //IC7400
    digitalWrite(50,HIGH);
    digitalWrite(17,LOW);
    digitalWrite(11,HIGH);
    digitalWrite(12,HIGH);
    digitalWrite(14,HIGH);
    digitalWrite(15,HIGH);
    digitalWrite(45,HIGH);
    digitalWrite(46,HIGH);
    digitalWrite(48,HIGH);
    digitalWrite(49,HIGH);
    delay(10);
    if(!digitalRead(13) && !digitalRead(16) && !digitalRead(44) && !digitalRead(47))
    {
      digitalWrite(11,HIGH);
      digitalWrite(12,LOW);
      digitalWrite(14,HIGH);
      digitalWrite(15,LOW);
      digitalWrite(45,HIGH);
      digitalWrite(46,LOW);
      digitalWrite(48,HIGH);
      digitalWrite(49,LOW);
      delay(10);
      if(digitalRead(13) && digitalRead(16) && digitalRead(44) && digitalRead(47))
      {
        digitalWrite(12,HIGH);
        digitalWrite(11,LOW);
        digitalWrite(15,HIGH);
        digitalWrite(14,LOW);
        digitalWrite(46,HIGH);
        digitalWrite(45,LOW);
        digitalWrite(49,HIGH);
        digitalWrite(48,LOW);
        delay(10);
        if(digitalRead(13) && digitalRead(16) && digitalRead(44) && digitalRead(47))
        {
          digitalWrite(12,LOW);
          digitalWrite(11,LOW);
          digitalWrite(15,LOW);
          digitalWrite(14,LOW);
          digitalWrite(46,LOW);
          digitalWrite(45,LOW);
          digitalWrite(49,LOW);
          digitalWrite(48,LOW);
          delay(10);
          if(digitalRead(13) && digitalRead(16) && digitalRead(44) && digitalRead(47))
          {
            Serial.println("IC is working properly");
            while(true);
          }
          else
          {
            Serial.println("The IC is not working properly");
            while(true);
          }
        }
        else
        {
          Serial.println("The IC is not working properly");
          while(true);
        }
      }
      else
      {
        Serial.println("The IC is not working properly");
        while(true);
      }
    }
    else
    {
      Serial.println("The IC is not working properly");
      while(true);
    }
  }
  if(opt==2)
  {
    //IC7402
    digitalWrite(50,HIGH);
    digitalWrite(17,LOW);
    digitalWrite(11,HIGH);
    digitalWrite(12,HIGH);
    digitalWrite(14,HIGH);
    digitalWrite(15,HIGH);
    digitalWrite(45,HIGH);
    digitalWrite(46,HIGH);
    digitalWrite(48,HIGH);
    digitalWrite(49,HIGH);
    delay(10);
    if(!digitalRead(13) && !digitalRead(16) && !digitalRead(44) && !digitalRead(47))
    {
      digitalWrite(11,HIGH);
      digitalWrite(12,LOW);
      digitalWrite(14,HIGH);
      digitalWrite(15,LOW);
      digitalWrite(45,HIGH);
      digitalWrite(46,LOW);
      digitalWrite(48,HIGH);
      digitalWrite(49,LOW);
      delay(10);
      if(!digitalRead(13) && !digitalRead(16) && !digitalRead(44) && !digitalRead(47))
      {
        digitalWrite(12,HIGH);
        digitalWrite(11,LOW);
        digitalWrite(15,HIGH);
        digitalWrite(14,LOW);
        digitalWrite(46,HIGH);
        digitalWrite(45,LOW);
        digitalWrite(49,HIGH);
        digitalWrite(48,LOW);
        delay(10);
        if(!digitalRead(13) && !digitalRead(16) && !digitalRead(44) && !digitalRead(47))
        {
          digitalWrite(12,LOW);
          digitalWrite(11,LOW);
          digitalWrite(15,LOW);
          digitalWrite(14,LOW);
          digitalWrite(46,LOW);
          digitalWrite(45,LOW);
          digitalWrite(49,LOW);
          digitalWrite(48,LOW);
          delay(10);
          if(digitalRead(13) && digitalRead(16) && digitalRead(44) && digitalRead(47))
          {
            Serial.println("IC is working properly");
            while(true);
          }
          else
          {
            Serial.println("The IC is not working properly");
            while(true);
          }
        }
        else
        {
          Serial.println("The IC is not working properly");
          while(true);
        }
      }
      else
      {
        Serial.println("The IC is not working properly");
        while(true);
      }
    }
    else
    {
      Serial.println("The IC is not working properly");
      while(true);
    }
  }
}
void train()
{
  Serial.println("Happy training");
  digitalWrite(51,HIGH);
}
