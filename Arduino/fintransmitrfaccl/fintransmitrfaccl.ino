/*
    Arduino and ADXL345 Accelerometer Tutorial
     by Dejan, https://howtomechatronics.com
*/
#include <RH_ASK.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345_U.h>
float X_out, Y_out, Z_out;  // Outputs
RH_ASK driver;
Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified();
void setup()
{
  Serial.begin(9600); // Initiate serial communication for printing the results on the Serial monitor
  if (!driver.init())
         Serial.println("init failed");
  Serial.println("Begin");
  if (!accel.begin())
  {
    Serial.println("No ADXL345 sensor detected.");
    while (1);
  }
  Serial.println("B4");
  delay(10);
  Serial.println("After");
}
void loop()
{
  Serial.println("Loop");
  sensors_event_t event;
  accel.getEvent(&event);
  X_out = event.acceleration.x;
  Y_out = event.acceleration.y;
  Z_out = event.acceleration.z;
  Serial.print("X: "); Serial.print(X_out); Serial.print("  ");
  Serial.print("Y: "); Serial.print(Y_out); Serial.print("  ");
  Serial.print("Z: "); Serial.print(Z_out); Serial.print("  ");
  Serial.println("m/s^2 ");
  X_out=X_out*20;
  Y_out=Y_out*20;
  Z_out=Z_out*20;
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
