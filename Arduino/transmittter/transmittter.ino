/*
    Arduino and ADXL345 Accelerometer Tutorial
     by Dejan, https://howtomechatronics.com
*/
#include <RH_ASK.h>
#include <SPI.h>
#include <Wire.h>  // Wire library - used for I2C communication
int ADXL345 = 0x53; // The ADXL345 sensor I2C address
float X_out, Y_out, Z_out;  // Outputs
RH_ASK driver;
void setup()
{
  Serial.begin(9600); // Initiate serial communication for printing the results on the Serial monitor
  if (!driver.init())
         Serial.println("init failed");
  Wire.begin(); // Initiate the Wire library
  // Set ADXL345 in measuring mode
  Wire.beginTransmission(ADXL345); // Start communicating with the device 
  Wire.write(0x2D); // Access/ talk to POWER_CTL Register - 0x2D
  // Enable measurement
  Wire.write(8); // (8dec -> 0000 1000 binary) Bit D3 High for measuring enable 
  Wire.endTransmission();
  delay(10);
}
void loop()
{
  Wire.beginTransmission(ADXL345);
  Wire.write(0x32); // Start with register 0x32 (ACCEL_XOUT_H)
  Wire.endTransmission(false);
  Wire.requestFrom(ADXL345, 6, true); // Read 6 registers total, each axis value is stored in 2 registers
  X_out = ( Wire.read()| Wire.read() << 8);
  Y_out = ( Wire.read()| Wire.read() << 8);
  Z_out = ( Wire.read()| Wire.read() << 8);
  Serial.print("Xa= ");
  Serial.print(X_out);
  Serial.print("   Ya= ");
  Serial.print(Y_out);
  Serial.print("   Za= ");
  Serial.println(Z_out);
  if ((X_out>-150 && X_out<150) && (Y_out>-150 && Y_out<150)) //stationary or stop(transmitter parallel to ground)
  {
    char *msg="s";
    Serial.println(*msg);
    driver.send((uint8_t*)msg,strlen(msg));
    driver.waitPacketSent();
    delay(1000);
  } 
  else 
  { 
    if (Y_out<-150) //forward(transmitter tilted forward)
    {
      char *msg="f";
      Serial.println(*msg);
      driver.send((uint8_t*)msg,strlen(msg));
      driver.waitPacketSent();
      delay(1000);
    }
    if (Y_out>150) //backward(transmitter tilted backward)
    {
      char *msg="a";
      Serial.println(*msg);
      driver.send((uint8_t*)msg,strlen(msg));
      driver.waitPacketSent();
      delay(1000);
    }
    if (X_out>150) //left(transmitter tilted to left)
    {
      char *msg="l";
      Serial.println(*msg);
      driver.send((uint8_t*)msg,strlen(msg));
      driver.waitPacketSent();
      delay(1000);
    }
    if (X_out<-150)//right(transmitter tilted to right)
    {
      char *msg="r";
      Serial.println(*msg);
      driver.send((uint8_t*)msg,strlen(msg));
      driver.waitPacketSent();
      delay(1000);
    }
  }
}
