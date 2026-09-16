/*
The circuit:
  * SD card attached to SPI bus as follows:
 ** MOSI - pin 11 on Arduino Uno/Duemilanove/Diecimila
 ** MISO - pin 12 on Arduino Uno/Duemilanove/Diecimila
 ** CLK - pin 13 on Arduino Uno/Duemilanove/Diecimila
 ** CS - pin 4 on Arduino Uno/Duemilanove/Diecimila.
 
  *TFT connected as follows:
 **CS - pin 10
 **DC - pin 9
 **RST - pin 8
*/

#include<SD.h>
#include<TFT.h>
#include<SPI.h>
#define cs 10
#define dc 9
#define rst 8
TFT TFTScreen=TFT(cs,dc,rst);
char sensorPrintout[4];
int css=4;
void setup()
{
  TFTscreen.begin();
  TFTscreen.background(0, 0, 0);
  TFTscreen.stroke(255,255,255);
  TFTscreen.setTextSize(2);
  TFTscreen.text("Sensor Value :\n ",0,0);
  TFTscreen.setTextSize(5);
  Serial.begin(9600);
  Serial.println("Initializing SD Card");
  if (!SD.begin(css))
  {
    Serial.println("Card failed, or not present");
    return;
  }
  Serial.println("card initialized.");
}
void loop()
{
  File data=SD.open("acc.txt",FILE_WRITE);
  while(analogRead(A0)<200);
  int start=millis();
  delay(1000);
  while(analogRead(A0)<200);
  int ti=millis()-start;
  Serial.println(ti);
  if(data)
  {
    data.println(acc);
    data.close();
  }
  String sensorVal=String(acc);
  sensorVal.toCharArray(sensorPrintout, 4);
  TFTscreen.stroke(255,255,255);
  TFTscreen.text(sensorPrintout, 0, 20);
  delay(250);
  TFTscreen.stroke(0,0,0);
  TFTscreen.text(sensorPrintout, 0, 20);
}
