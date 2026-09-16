#include <SD.h>
#include<SPI.h>
File abc;

int pinCS=4;

const int dataIN1 = 2;//IR sensor INPUT
unsigned long prevmillis1; // To store time
unsigned long duration1; // To store time difference
unsigned long refresh1; // To store time for refresh of reading

int rpm1; // RPM value

int gr;
boolean currentstate1; // Current state of IR input scan
boolean prevstate1; // State of IR sensor in previous scan

void setup()
{
  pinMode(dataIN1,INPUT);
  pinMode(pinCS, OUTPUT);
  prevmillis1 = 0;
  prevstate1 = LOW;    
  Serial.begin(115200);
  
  if(SD.begin())
  {
    Serial.println("Ready to use SD");      
  }
  else
  {
    Serial.println("Failed");
    return;
  }
}
  

void loop()
{
 // RPM Measurement
  currentstate1 = digitalRead(dataIN1); // Read IR sensor state
 if( prevstate1 != currentstate1) // If there is change in input
   {
     if( currentstate1 == HIGH ) // If input only changes from LOW to HIGH
       {
         duration1 = ( micros() - prevmillis1 ); // Time difference between revolution in microsecond
         rpm1 = (60000000/duration1); // rpm = (1/ time millis)*1000*1000*60;
         prevmillis1 = micros(); // store time for nect revolution calculation
       }
     
   }
  prevstate1 = currentstate1; // store this scan (prev scan) data for next scan
  
  // LCD Display
  if( ( millis()-refresh1 ) >= 100 )
    {
      refresh1=millis();
       Serial.print("rpm1=");
       Serial.println(rpm1); 
       abc=SD.open("speed.txt",FILE_WRITE);
      if(abc)
      {
        abc.print("rpm1= ");
        abc.println(rpm1);
        
      } 
       
    }
    abc.close();
}
