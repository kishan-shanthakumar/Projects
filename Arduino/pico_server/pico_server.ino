#include "ThingSpeak.h"
#include <ESP8266WiFi.h>

//------- WI-FI details ----------//
char ssid[] = "BOSS"; //SSID here
char pass[] = "gangster"; // Passowrd here
//--------------------------------//

//----------- Channel details ----------------//
unsigned long Channel_ID = 1421207; // Your Channel ID
const char * myWriteAPIKey = "VNXX9GU65447TCQN"; //Your write API key
//-------------------------------------------//

const int Field_Number_1 = 1;
String value;
WiFiClient  client;

void setup()
{
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  pinMode(2, OUTPUT);
  digitalWrite(2,0);
  ThingSpeak.begin(client);
  internet();
}

void loop()
{
  while (Serial.available() > 0)
  {
    value = Serial.readString();
    Serial.println(value);
    upload();
  }
}

void internet()
{
  if (WiFi.status() != WL_CONNECTED)
  {
    while (WiFi.status() != WL_CONNECTED)
    {
      WiFi.begin(ssid, pass);
      delay(5000);
    }
  }
}

void upload()
{
  ThingSpeak.writeField(Channel_ID, Field_Number_1, value, myWriteAPIKey);
  delay(15000);
}
