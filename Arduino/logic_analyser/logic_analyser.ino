float duty = 0;
long freq = 0;
long time1 = 0;

void setup()
{
  pinMode(2,INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2), logic, CHANGE);
  Serial.begin(2000000);
}

void logic()
{
  if(digitalRead(2) == HIGH)
  {
    freq=1000000/(micros()-time1);
    time1=micros();
    Serial.print("Freq");
    Serial.print("  ");
    Serial.println(freq);
  }
  if(digitalRead(2) == LOW)
  {
    duty = ((micros()-time1)*freq*100/1000000);
    Serial.print("Duty");
    Serial.print("  ");
    Serial.println(duty);
  }
}

void loop()
{
  Serial.println(digitalRead(2));
  delay(1000);
}
