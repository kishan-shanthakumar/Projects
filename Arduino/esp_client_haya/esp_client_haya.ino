#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>

#include <Wire.h>
#include <MPU6050.h>

MPU6050 mpu;
MPU6050 mpu1;

unsigned long timer = 0;
float timeStep = 0.01;
float timeStep1 = 0.01;

// Pitch, Roll and Yaw values
float pitch = 0;
float roll = 0;
float yaw = 0;
float pitch1 = 0;
float roll1 = 0;
float yaw1 = 0;

int currr,prevr,currl,prevl;
float RPMr,RPMl;

#include <ESP8266WiFiMulti.h>
ESP8266WiFiMulti WiFiMulti;

const char* ssid = "ESP8266-Access-Point";
const char* password = "123456789";

//Your IP address or domain name with URL path
const char* serverrRPM = "http://192.168.4.1/rRPM";
const char* serverpotrr = "http://192.168.4.1/potrr";
const char* serverpotrl = "http://192.168.4.1/potrl";
const char* servernifli = "http://192.168.4.1/nifli";

String rRPM;
String potrr;
String potrl;
String nifli;
float potfr,potfl,frRPM,flRPM,angrw,anglw,angstr;

void setup() {
  attachInterrupt(digitalPinToInterrupt(2), rpmcalcr, FALLING);
  attachInterrupt(digitalPinToInterrupt(3), rpmcalcl, FALLING);
  Serial.begin(115200);
  Serial.println();
 
  WiFi.mode(WIFI_STA);
  WiFiMulti.addAP(ssid, password);
  while((WiFiMulti.run() == WL_CONNECTED)) { 
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("Connected to WiFi");
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
  // Get data from server
  // Check WiFi connection status
  if ((WiFiMulti.run() == WL_CONNECTED))
  {
    rRPM = httpGETRequest(serverrRPM);
    potrr = httpGETRequest(serverpotrr);
    potrl = httpGETRequest(serverpotrl);
    nifli = httpGETRequest(servernifli);
    Serial.println(rRPM+" "+potrr+" "+potrl+" "+nifli);
  }
  else {
    Serial.println("WiFi Disconnected");
  }

  //This device sensors
  
  int a = analogRead(A0);
  potfr = 150-a*150/1023;
  int b = analogRead(A0);
  potfl = 150-b*150/1023;

  //Wheel Angle
  timer = millis();

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
  Serial.println(yaw);
  Serial.print(" Pitch1 = ");
  Serial.print(pitch1);
  Serial.print(" Roll1 = ");
  Serial.print(roll1);  
  Serial.print(" Yaw1 = ");
  Serial.println(yaw1);

  // Wait to full timeStep period
  delay((timeStep*1000) - (millis() - timer));
}

void rpmcalcr()
{
  currr = millis();
  RPMr = 60000/(currr-prevr);
  prevr = currr;
}

void rpmcalcl()
{
  currl = millis();
  RPMl = 60000/(currl-prevl);
  prevl = currl;
}

String httpGETRequest(const char* serverName) {
  WiFiClient client;
  HTTPClient http;
    
  // Your IP address with path or Domain name with URL path 
  http.begin(client, serverName);
  
  // Send HTTP POST request
  int httpResponseCode = http.GET();
  
  String payload = "--"; 
  
  if (httpResponseCode>0) {
    payload = http.getString();
  }
  else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }
  // Free resources
  http.end();

  return payload;
}
