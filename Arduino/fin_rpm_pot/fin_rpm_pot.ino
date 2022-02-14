#include <SD.h>
#include<SPI.h>
File abc;

int pinCS = 10;
int x1 = 0;
int y1 = 0;

const int dataIN1 = 2;//IR sensor INPUT
unsigned long prevmillis1; // To store time
unsigned long duration1; // To store time difference
unsigned long refresh1; // To store time for refresh of reading
const int dataIN2 = 3;//IR sensor INPUT
unsigned long prevmillis2; // To store time
unsigned long duration2; // To store time difference
unsigned long refresh2; // To store time for refresh of reading
const int dataIN3 = 4;//IR sensor INPUT
unsigned long prevmillis3; // To store time
unsigned long duration3; // To store time difference
unsigned long refresh3; // To store time for refresh of reading
const int dataIN4 = 5;//IR sensor INPUT
unsigned long prevmillis4; // To store time
unsigned long duration4; // To store time difference
unsigned long refresh4; // To store time for refresh of reading

int rpm1; // RPM value
int rpm2;
int rpm3;
int rpm4;

int gr;
boolean currentstate1; // Current state of IR input scan
boolean prevstate1; // State of IR sensor in previous scan
boolean currentstate2; // Current state of IR input scan
boolean prevstate2; // State of IR sensor in previous scan
boolean currentstate3; // Current state of IR input scan
boolean prevstate3; // State of IR sensor in previous scan
boolean currentstate4; // Current state of IR input scan
boolean prevstate4; // State of IR sensor in previous scan

void setup()
{
  pinMode(dataIN1, INPUT);
  pinMode(dataIN2, INPUT);
  pinMode(dataIN3, INPUT);
  pinMode(dataIN4, INPUT);
  pinMode(pinCS, OUTPUT);
  prevmillis1 = 0;
  prevstate1 = LOW;
  prevmillis2 = 0;
  prevstate2 = LOW;
  prevmillis3 = 0;
  prevstate3 = LOW;
  prevmillis4 = 0;
  prevstate4 = LOW;
  Serial.begin(115200);

  if (SD.begin())
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
  abc = SD.open("speed.txt", FILE_WRITE);
  // RPM Measurement
  currentstate1 = digitalRead(dataIN1); // Read IR sensor state
  if ( prevstate1 != currentstate1) // If there is change in input
  {
    if ( currentstate1 == HIGH ) // If input only changes from LOW to HIGH
    {
      duration1 = ( millis() - prevmillis1 ); // Time difference between revolution in microsecond
      rpm1 = (60000 / duration1); // rpm = (1/ time millis)*1000*1000*60;
      prevmillis1 = millis(); // store time for nect revolution calculation
    }

  }
  prevstate1 = currentstate1; // store this scan (prev scan) data for next scan


  currentstate2 = digitalRead(dataIN2); // Read IR sensor state
  if ( prevstate2 != currentstate2) // If there is change in input
  {
    if ( currentstate2 == HIGH ) // If input only changes from LOW to HIGH
    {
      duration2 = ( millis() - prevmillis2 ); // Time difference between revolution in microsecond
      rpm2 = (60000 / duration2); // rpm = (1/ time millis)*1000*1000*60;
      prevmillis2 = millis(); // store time for nect revolution calculation
    }

  }
  prevstate2 = currentstate2; // store this scan (prev scan) data for next scan


  currentstate3 = digitalRead(dataIN3); // Read IR sensor state
  if ( prevstate3 != currentstate3) // If there is change in input
  {
    if ( currentstate3 == HIGH ) // If input only changes from LOW to HIGH
    {
      duration3 = ( millis() - prevmillis3 ); // Time difference between revolution in microsecond
      rpm3 = (60000 / duration3); // rpm = (1/ time millis)*1000*1000*60;
      prevmillis3 = millis(); // store time for nect revolution calculation
    }

  }
  prevstate3 = currentstate3; // store this scan (prev scan) data for next scan


  currentstate4 = digitalRead(dataIN4); // Read IR sensor state
  if ( prevstate4 != currentstate4) // If there is change in input
  {
    if ( currentstate4 == HIGH ) // If input only changes from LOW to HIGH
    {
      duration4 = ( millis() - prevmillis4 ); // Time difference between revolution in microsecond
      rpm4 = (60000 / duration4); // rpm = (1/ time millis)*1000*1000*60;
      prevmillis4 = millis(); // store time for nect revolution calculation
    }

  }
  prevstate4 = currentstate4; // store this scan (prev scan) data for next scan

  rpm1=rpm1/2;
  rpm2=rpm2/4;
  rpm3=rpm3/8;

  Serial.print("rpm1=");
  Serial.println(rpm1);
  Serial.print("rpm2=");
  Serial.println(rpm2);
  Serial.print("rpm3=");
  Serial.println(rpm3);
  Serial.print("rpm4=");
  Serial.println(rpm4);
  
  //Potentiometer measurement
  x1 = analogRead(A0);
  y1 = 150.00 - x1 * 150.0 / 1022.0;
  Serial.print(y1);
  Serial.print(" ");
  Serial.println(millis());
  if (abc)
  {
    abc.print("Back= ");
    abc.println(rpm1);
    abc.print("Front= ");
    abc.println(rpm2);
    abc.print("PriCVT= ");
    abc.println(rpm3);
    abc.print("SecCVT= ");
    abc.println(rpm4);
    abc.print("Pot Length");
    abc.print(y1);
    abc.print(" ");
    abc.println(millis());
  }
  abc.close();
}
