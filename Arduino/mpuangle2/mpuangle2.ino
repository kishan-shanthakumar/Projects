#include <Wire.h>
#include <MPU6050.h>

MPU6050 mpu;
MPU6050 mpu1;

// Timers
unsigned long timer = 0;
float timeStep = 0.01;
unsigned long timer1 = 0;
float timeStep1 = 0.01;

// Pitch, Roll and Yaw values
float pitch = 0;
float roll = 0;
float yaw = 0;
float pitch1 = 0;
float roll1 = 0;
float yaw1 = 0;

void setup() 
{
  Serial.begin(115200);

  // Initialize MPU6050
  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G,0x68))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }
  while(!mpu1.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G,0x69))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }
  
  // Calibrate gyroscope. The calibration must be at rest.
  // If you don't want calibrate, comment this line.
  mpu.calibrateGyro();
  mpu1.calibrateGyro();

  // Set threshold sensivty. Default 3.
  // If you don't want use threshold, comment this line or set 0.
  mpu.setThreshold(3);
  mpu1.setThreshold(3);
}

void loop()
{
  timer = millis();
  timer1 = millis();

  // Read normalized values
  Vector norm = mpu.readNormalizeGyro();
  Vector norm1 = mpu1.readNormalizeGyro();

  // Calculate Pitch, Roll and Yaw
  pitch = pitch + norm.YAxis * timeStep;
  roll = roll + norm.XAxis * timeStep;
  yaw = yaw + norm.ZAxis * timeStep;
  pitch1 = pitch1 + norm1.YAxis * timeStep1;
  roll1 = roll1 + norm1.XAxis * timeStep1;
  yaw1 = yaw1 + norm1.ZAxis * timeStep1;

  // Output raw
  Serial.print(" Pitch = ");
  Serial.print(pitch);
  Serial.print(" Roll = ");
  Serial.print(roll);  
  Serial.print(" Yaw = ");
  Serial.print(yaw);
  Serial.print(" Pitch1 = ");
  Serial.print(pitch1);
  Serial.print(" Roll1 = ");
  Serial.print(roll1);  
  Serial.print(" Yaw1 = ");
  Serial.println(yaw1);

  // Wait to full timeStep period
  delay((timeStep*1000) - (millis() - timer));
}
