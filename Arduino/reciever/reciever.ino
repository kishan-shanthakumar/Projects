#include <RH_ASK.h>
#include <SPI.h> // Not actualy used but needed to compile

int lm=9;
int lmr=8;
int rm=10;
int rmr=7;
int ledPin=13;

RH_ASK driver;

void setup()
{
    Serial.begin(9600);  // Debugging only
    if (!driver.init())
         Serial.println("init failed");
    else
         Serial.println("Done");
}

void loop()
{
    uint8_t buf[1];
    uint8_t buflen = sizeof(buf);
    if (driver.recv(buf, &buflen)) // Non-blocking
    {
      int i;
      // Message with a good checksum received, dump it.
      Serial.print("Message: ");
      Serial.println((char*)buf);         
    }
    if (buf[0]==0x73)//Stationary
    {
      digitalWrite(lm,LOW);  
      digitalWrite(lmr,LOW);
      digitalWrite(rm,LOW);
      digitalWrite(rmr,LOW);
    
      digitalWrite(ledPin,LOW);
    }
    else
    {
      if(buf[0]==0x66)//Forward
      {
        digitalWrite(lm,LOW);  
        digitalWrite(lmr,HIGH);
        digitalWrite(rm,HIGH);
        digitalWrite(rmr,LOW);
        
        digitalWrite(ledPin,HIGH);
      }
    
      if (buf[0]==0x61)//Backward
      {
        digitalWrite(lm,HIGH);  
        digitalWrite(lmr,LOW);
        digitalWrite(rm,LOW);
        digitalWrite(rmr,HIGH);
        
        digitalWrite(ledPin,HIGH);
    }
    
      if (buf[0]==0x72)//Left 
      {
        digitalWrite(lm,LOW);  
        digitalWrite(lmr,HIGH);
        digitalWrite(rm,HIGH);
        digitalWrite(rmr,LOW);
        digitalWrite(ledPin,HIGH);
      }
    
      if (buf[0]==0x6C)//Right 
      {
        digitalWrite(lm,LOW);  
        digitalWrite(lmr,HIGH);
        digitalWrite(rm,HIGH);
        digitalWrite(rmr,LOW);
        digitalWrite(ledPin,HIGH);
      }
  }
}
