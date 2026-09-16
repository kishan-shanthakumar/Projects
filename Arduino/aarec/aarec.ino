#include<Wire.h>
void setup()
{
  Serial.begin(9600);
  Wire.begin();
}

void loop()
{
  Wire.requestFrom(8,1);
  int rec = Wire.read();
  Serial.println(rec);
  delay(500);
}
