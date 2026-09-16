#include<SD.h>
void setup()
{
  SD.begin(4);
  Serial.begin(9600);
}
void loop()
{
  File data=SD.open("acc.txt",FILE_WRITE);
  while(analogRead(A0)<200);
  int start=millis();
  delay(500);
  while(analogRead(A0)<200);
  int ti=millis()-start;
  Serial.println(ti);
  String tim=String(ti);
  if(data)
  {
    data.println(tim);
    data.close();
  }
  while(true);
}
