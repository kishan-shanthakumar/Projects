const int OUT_PIN = A5;
const int IN_PIN = A0;
const float IN_STRAY_CAP_TO_GND = 24.48;
const float IN_CAP_TO_GND  = IN_STRAY_CAP_TO_GND;
//const float R_PULLUP = 24.8;  
const int MAX_ADC_VALUE = 1023;
const int numReadings = 24;

int readings[numReadings];      // the readings from the analog input
int readIndex = 0;              // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average
void setup()
{
  pinMode(OUT_PIN, OUTPUT);
  pinMode(IN_PIN, OUTPUT);
  Serial.begin(9600);
  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
  pinMode(3,HIGH);
  //delay(3000);
  pinMode(3,LOW);
  //delay(3000);
  pinMode(4,HIGH);
  //delay(3000);
  pinMode(4,LOW);
  //delay(3000);
  pinMode(5,HIGH);
  //delay(3000);
  pinMode(5,LOW);
}

void loop()
{
    delay(3000);
    pinMode(IN_PIN, INPUT);
    digitalWrite(OUT_PIN, HIGH);
    int val = analogRead(IN_PIN);
    digitalWrite(OUT_PIN, LOW);

    if (val < 1000)
    {
      pinMode(IN_PIN, OUTPUT);

      float capacitance = (float)val * IN_CAP_TO_GND / (float)(MAX_ADC_VALUE - val);
      // subtract the last reading:
      total = total - readings[readIndex];
      // read from the sensor:
      readings[readIndex] = capacitance;
      // add the reading to the total:
      total = total + readings[readIndex];
      // advance to the next position in the array:
      readIndex = readIndex + 1;

      // if we're at the end of the array...
      if (readIndex >= numReadings) {
      // ...wrap around to the beginning:
      readIndex = 0;
      }   
      // calculate the average:
      average = total / numReadings;
      // send it to the computer as ASCII digits
       
     
      Serial.println(val);
      if(val>140)
      {
        digitalWrite(5,HIGH);
        delay(3000);
        digitalWrite(4,HIGH);
        delay(3000);
        digitalWrite(3,HIGH);
      }
      if(val<140 && val>125)
      {
        digitalWrite(5,LOW);
        digitalWrite(4,HIGH);
        digitalWrite(3,HIGH);
      }
      if(val<125 && val>110)
      {
        digitalWrite(5,LOW);
        digitalWrite(4,LOW);
        digitalWrite(3,HIGH);
      }
      if(val<110)
      {
        digitalWrite(5,LOW);
        digitalWrite(4,LOW);
        digitalWrite(3,LOW);
      }
      delay(200);
    }
/*    else
    {
      pinMode(IN_PIN, OUTPUT);
      delay(1000);
      pinMode(OUT_PIN, INPUT_PULLUP);
      unsigned long u1 = micros();
      unsigned long t;
      int digVal;

      do
      {
        digVal = digitalRead(OUT_PIN);
        unsigned long u2 = micros();
        t = u2 > u1 ? u2 - u1 : u1 - u2;
      } while ((digVal < 1) && (t < 400000L));

      pinMode(OUT_PIN, INPUT);  
      val = analogRead(OUT_PIN);
      digitalWrite(IN_PIN, HIGH);
      int dischargeTime = (int)(t / 1000L) * 5;
      delay(dischargeTime);   
      pinMode(OUT_PIN, OUTPUT);  
      digitalWrite(OUT_PIN, LOW);
      digitalWrite(IN_PIN, LOW);

      float capacitance = -(float)t / R_PULLUP
                              / log(1.0 - (float)val / (float)MAX_ADC_VALUE);

       Serial.print(F("Capacitance Value = "));
      if (capacitance > 1000.0)
      {
        Serial.print(capacitance / 1000.0, 2);
        Serial.print(F(" uF"));
      }
      else
      {
        Serial.print(capacitance, 2);
        Serial.print(F(" nF"));
      }

      Serial.print(F(" ("));
      Serial.print(digVal == 1 ? F("Normal") : F("HighVal"));
      Serial.print(F(", t= "));
      Serial.print(t);
      Serial.print(F(" us, ADC= "));
      Serial.print(val);
      Serial.println(F(")"));
    }
    while (millis() % 1000 != 0)
      ;    
*/      
}
