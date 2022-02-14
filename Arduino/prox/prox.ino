#include <SD.h>
#include<SPI.h>

File abc;

int CS_PIN=4;

int sensorVal;
const unsigned long sampleTime = 1000;
int rpm = 0;

void initializeSD()
{
  Serial.println("Initializing SD card...");
  pinMode(CS_PIN, OUTPUT);

  if (SD.begin())
  {
    Serial.println("SD card is ready to use.");
  } else
  {
    Serial.println("SD card initialization failed");
    return;
  }
}

void setup() {
  //start serial connection
  Serial.begin(9600);
  //configure pin 2 as an input and enable the internal pull-up resistor
  pinMode(2, INPUT_PULLUP);
  pinMode(13, OUTPUT);
  initializeSD();
}

void loop() 
{
  abc=SD.open("rpm.txt",FILE_WRITE);
  int rpm=getRPM();
  Serial.println(rpm);
  abc.println(rpm);
  abc.close();
}
int getRPM()
{
  int count = 0;
  boolean countFlag = LOW;
  unsigned long currentTime = 0;
  unsigned long startTime = millis();
  while (currentTime <= sampleTime)
  {
    if (digitalRead(2) == LOW)
    {
      countFlag = HIGH;
    }
    if (digitalRead(2) == HIGH && countFlag == HIGH)
    {
      count++;
      countFlag=LOW;
    }
    currentTime = millis() - startTime;
  }
  int countRpm = int(60*count/4);
  return countRpm;
}
