#include<Wire.h>
const int OUT_PIN = A3;
const int IN_PIN = A0;
const float IN_STRAY_CAP_TO_GND = 24.48;
const float IN_CAP_TO_GND  = IN_STRAY_CAP_TO_GND;
//const float R_PULLUP = 24.8;  
const int MAX_ADC_VALUE = 1023;
const int numReadings = 24;

int readings[numReadings];      // the readings from the analog input
int readIndex = 0;              // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average
int accdat;
void setup()
{
  pinMode(OUT_PIN, OUTPUT);
  pinMode(IN_PIN, OUTPUT);
  Serial.begin(9600);
  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
  Wire.begin(8);
  Wire.onRequest(requestEvent);
}

void loop()
{
    delay(3000);
    pinMode(IN_PIN, INPUT);
    digitalWrite(OUT_PIN, HIGH);
    int val = analogRead(IN_PIN);
    digitalWrite(OUT_PIN, LOW);

    if (val < 1000)
    {
      pinMode(IN_PIN, OUTPUT);

      float capacitance = (float)val * IN_CAP_TO_GND / (float)(MAX_ADC_VALUE - val);
      // subtract the last reading:
      total = total - readings[readIndex];
      // read from the sensor:
      readings[readIndex] = capacitance;
      // add the reading to the total:
      total = total + readings[readIndex];
      // advance to the next position in the array:
      readIndex = readIndex + 1;

      // if we're at the end of the array...
      if (readIndex >= numReadings) {
      // ...wrap around to the beginning:
      readIndex = 0;
      }   
      // calculate the average:
      average = total / numReadings;
      // send it to the computer as ASCII digits
       
      accdat = val;
      Serial.println(val);
    }
}
void requestEvent()
{
  Wire.write(accdat);
}
