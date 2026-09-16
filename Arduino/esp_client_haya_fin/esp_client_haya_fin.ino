#include <Arduino.h>

#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>

#include <ESP8266HTTPClient.h>

#include <WiFiClient.h>

ESP8266WiFiMulti WiFiMulti;

String fuel_level,data,potrr,potrl;

const int dataIN1 = 2;//IR sensor INPUT
const int dataIN2 = 3;
const int dataIN3 = 4;
unsigned long prevmillis1; // To store time
unsigned long prevmillis2;
unsigned long prevmillis3;
unsigned long duration1; // To store time difference
unsigned long duration2;
unsigned long duration3;
unsigned long refresh1; // To store time for refresh of reading
unsigned long refresh2;
unsigned long refresh3;

int rpm1; // RPM value
int rpm2;
int rpm3;

int gr;
boolean currentstate1; // Current state of IR input scan
boolean currentstate2;
boolean currentstate3;
boolean prevstate1; // State of IR sensor in previous scan
boolean prevstate2;
boolean prevstate3;

void setup() {

  Serial.begin(115200);
  // Serial.setDebugOutput(true);

  Serial.println();
  Serial.println();
  Serial.println();

  for (uint8_t t = 4; t > 0; t--) {
    Serial.printf("[SETUP] WAIT %d...\n", t);
    Serial.flush();
    delay(1000);
  }

  WiFi.mode(WIFI_STA);
  WiFiMulti.addAP("SSID", "PASSWORD");
  
  prevmillis1 = 0;
  prevmillis2 = 0;
  prevmillis3 = 0;
  prevstate1 = LOW;
  prevstate2 = LOW; 
  prevstate3 = LOW;  

}

void loop() {
  // wait for WiFi connection
  if ((WiFiMulti.run() == WL_CONNECTED)) {

    WiFiClient client;

    HTTPClient http;

    Serial.print("[HTTP] begin...\n");
    if (http.begin(client, "http://jigsaw.w3.org/HTTP/connection.html")) {  // HTTP data


      Serial.print("[HTTP] GET...\n");
      // start connection and send HTTP header
      int httpCode = http.GET();

      // httpCode will be negative on error
      if (httpCode > 0) {
        // HTTP header has been send and Server response header has been handled
        Serial.printf("[HTTP] GET... code: %d\n", httpCode);

        // file found at server
        if (httpCode == HTTP_CODE_OK || httpCode == HTTP_CODE_MOVED_PERMANENTLY) {
          String payload = http.getString();
          Serial.println(payload);
        }
      } else {
        Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
      }

      http.end();
    } else {
      Serial.printf("[HTTP} Unable to connect\n");
    }
  }

  currentstate1 = digitalRead(dataIN1); // Read IR sensor state
 if( prevstate1 != currentstate1) // If there is change in input
   {
     if( currentstate1 == HIGH ) // If input only changes from LOW to HIGH
       {
         duration1 = ( micros() - prevmillis1 ); // Time difference between revolution in microsecond
         rpm1 = (60000000/duration1); // rpm = (1/ time millis)*1000*1000*60;
         prevmillis1 = micros(); // store time for nect revolution calculation
       }
     
   }
  prevstate1 = currentstate1; // store this scan (prev scan) data for next scan

  currentstate2 = digitalRead(dataIN2); // Read IR sensor state
 if( prevstate2 != currentstate2) // If there is change in input
   {
     if( currentstate2 == HIGH ) // If input only changes from LOW to HIGH
       {
         duration2 = ( micros() - prevmillis2 ); // Time difference between revolution in microsecond
         rpm2 = (60000000/duration2); // rpm = (1/ time millis)*1000*1000*60;
         prevmillis2 = micros(); // store time for nect revolution calculation
       }
   }
  prevstate2 = currentstate2; // store this scan (prev scan) data for next scan

  currentstate3 = digitalRead(dataIN3); // Read IR sensor state
 if( prevstate3 != currentstate3) // If there is change in input
   {
     if( currentstate3 == HIGH ) // If input only changes from LOW to HIGH
       {
         duration3 = ( micros() - prevmillis3 ); // Time difference between revolution in microsecond
         rpm3 = (60000000/duration3); // rpm = (1/ time millis)*1000*1000*60;
         prevmillis3 = micros(); // store time for nect revolution calculation
       }
     
   }
  prevstate3 = currentstate3; // store this scan (prev scan) data for next scan

  digitalWrite(12,HIGH);  
  int a = analogRead(A0);
  digitalWrite(12,LOW);
  int b = analogRead(A0);
  potrr = String(150-a*150/1023);
  potrl = String(150-b*150/1023);
  data = String(rpm1) + " " + String(rpm2) + " " + String(rpm3) + " " + potrl + " " + potrr + " " + fuel_level;
  delay(100);
}
