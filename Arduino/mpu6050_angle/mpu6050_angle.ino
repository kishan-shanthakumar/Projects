#include<Wire.h>
#include "I2Cdev.h"
#include "MPU6050.h"

MPU6050 accelgyroIC1(0x68);
MPU6050 accelgyroIC2(0x69);

int16_t ax1, ay1, az1;
int16_t gx1, gy1, gz1;

int16_t ax2, ay2, az2;
int16_t gx2, gy2, gz2;

#define LED_PIN 13
bool blinkState = false;

void setup()
{
  Wire.begin();
  Serial.begin(38400);
  Serial.println("Initializing I2C devices...");
  accelgyroIC1.initialize();
  accelgyroIC2.initialize();
  Serial.println("Testing device connections...");
  Serial.println(accelgyroIC1.testConnection() ? "MPU6050 #1 connection successful" : "MPU6050 connection failed");
  Serial.println(accelgyroIC2.testConnection() ? "MPU6050 #2 connection successful" : "MPU6050 connection failed");
  pinMode(LED_PIN, OUTPUT);
}

void loop()
{
  // read raw accel/gyro measurements from device
  accelgyroIC1.getMotion6(&ax1, &ay1, &az1, &gx1, &gy1, &gz1);
  accelgyroIC2.getMotion6(&ax2, &ay2, &az2, &gx2, &gy2, &gz2);
  Serial.print("MPU1:\t");
  Serial.print(ax1); Serial.print("\t");
  Serial.print(ay1); Serial.print("\t");
  Serial.print(az1); Serial.print("\t");
  Serial.print(gx1); Serial.print("\t");
  Serial.print(gy1); Serial.print("\t");
  Serial.println(gz1);
  Serial.print("MPU2:\t");
  Serial.print(ax2); Serial.print("\t");
  Serial.print(ay2); Serial.print("\t");
  Serial.print(az2); Serial.print("\t");
  Serial.print(gx2); Serial.print("\t");
  Serial.print(gy2); Serial.print("\t");
  Serial.println(gz2);
  blinkState = !blinkState;
  digitalWrite(LED_PIN, blinkState);
}
