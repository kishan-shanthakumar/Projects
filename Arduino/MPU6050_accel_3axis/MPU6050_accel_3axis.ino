#include<Wire.h>
#include<SD.h>

const int MPU=0x68;

File velacc;
int i=0;

//Variaveis para armazenar valores dos sensores
int pinCS = 10;
float AcX;
float vx=0;
float pmx;
float a0;

void setup()
{
  Serial.begin(2000000);
  Wire.setClock(400000L);
  Wire.begin();
  Wire.beginTransmission(MPU);
  Wire.write(0x6B);
  Wire.write(0);
  Wire.endTransmission(true);
  if (SD.begin())
  {
    Serial.println("Ready to use SD");
  }
  else
  {
    Serial.println("Failed");
  }
}
void loop()
{
  velacc=SD.open("vel.txt",FILE_WRITE);
  pmx=micros();
  Wire.beginTransmission(MPU);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU,14,true);
  AcX=Wire.read()<<8|Wire.read();
  AcX/=1671;
  if(i==0)
  {
    a0=AcX;
  }
  AcX-=a0;
  if(AcX<0.09 && AcX>-0.09)
    AcX=0.00;
  vx+=(AcX*(micros()-pmx)/1000000);
  velacc.print("A = "); velacc.print(AcX);
  velacc.print("\tV = ");velacc.print(vx);
  velacc.print("\t");velacc.println(micros());
  velacc.close();
  i++;
}
