#include <SD.h>
#include<SPI.h>

void setup() {
  // put your setup code here, to run once:
  digitalWrite(2,HIGH);
Serial.begin(9600);
if(SD.begin(4))
{
  Serial.println("done");
  }
  else
  Serial.println("fail");
}

void loop() {
  // put your main code here, to run repeatedly:

}
