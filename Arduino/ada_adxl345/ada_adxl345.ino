#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345_U.h>

Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified();

void setup(void)
{
  Serial.begin(9600);
  if (!accel.begin())
  {
    Serial.println("No ADXL345 sensor detected.");
    while (1);
  }
}
void loop(void)
{
  sensors_event_t event;
  accel.getEvent(&event);
  float xxx = event.acceleration.x;
  float yyy = event.acceleration.y;
  float zzz = event.acceleration.z;
  Serial.print("X: "); Serial.print(xxx); Serial.print("  ");
  Serial.print("Y: "); Serial.print(yyy); Serial.print("  ");
  Serial.print("Z: "); Serial.print(zzz); Serial.print("  ");
  Serial.println("m/s^2 ");
  delay(500);
}
