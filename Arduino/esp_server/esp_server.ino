#include <ESP8266WiFi.h>
#include "ESPAsyncWebServer.h"

const char* ssid = "ESP8266-Access-Point";
const char* password = "123456789";
AsyncWebServer server(80);

void setup()
{
  Serial.begin(115200);
  Serial.print("Setting AP (Access Point)…\n");
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);
  server.on("/temperature", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "None_t");
  });
  server.on("/humidity", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "None_h");
  });
  server.on("/pressure", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "None_p");
  });
  server.begin();
}

void loop(){}
