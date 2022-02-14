#include <ESP8266WiFi.h>
#include "ESPAsyncWebServer.h"
#include <ESP8266WiFiMulti.h>
ESP8266WiFiMulti WiFiMulti;

const char* ssid = "ESP8266-Access-Point";
const char* password = "123456789";
AsyncWebServer server(80);

float RPM = 0.0;
String potrr,potrl,rpm,fuel_level;
int curr,prev=0;

void setup()
{
  attachInterrupt(digitalPinToInterrupt(2), rpmcalc, FALLING);
  Serial.begin(115200);
  
  WiFi.mode(WIFI_STA);
  WiFiMulti.addAP(ssid, password);
  while((WiFiMulti.run() == WL_CONNECTED)) { 
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("Connected to WiFi");
  
  Serial.print("AP IP address: ");
  
  server.on("/rRPM", HTTP_GET, [](AsyncWebServerRequest *request)
  {
    request->send_P(200, "text/plain", rpm);
  });
  server.on("/potrr", HTTP_GET, [](AsyncWebServerRequest *request)
  {
    request->send_P(200, "text/plain", potrr);
  });
  server.on("/potrl", HTTP_GET, [](AsyncWebServerRequest *request)
  {
    request->send_P(200, "text/plain", potrl);
  });
  server.on("/nifli", HTTP_GET, [](AsyncWebServerRequest *request)
  {
    request->send_P(200, "text/plain", fuel_level);
  });
  server.begin();

  RPM = 0;
}

void loop()
{
  int a = analogRead(A0);
  potrr = String(150-a*150/1023);
  int b = analogRead(A0);
  potrl = String(150-b*150/1023);
  attachInterrupt(digitalPinToInterrupt(2), rpmcalc, FALLING);
  delay(1000);
  detachInterrupt(digitalPinToInterrupt(2));
  rpm = String(RPM*60);
  RPM = 0;
}

void rpmcalc()
{
  RPM++;
}
