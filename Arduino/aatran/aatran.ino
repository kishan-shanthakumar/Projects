#include<Wire.h>
int i=0;
void setup()
{
  Serial.begin(9600);
  Wire.begin(8);
  Wire.onRequest(requestEvent);
}

void loop()
{
  
}
void requestEvent()
{
  i+=1;
  Wire.write(i);
}
