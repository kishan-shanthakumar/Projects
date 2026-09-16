void setup()
{
  Serial.begin(9600);
  pinMode(2,INPUT);
}

void loop()
{
  if(analogRead(3)>200)
  {
    int start=millis();
    while(digitalRead(2)==HIGH);
    int ti=millis()-start;
    Serial.println(ti);
    delay(1000);
  }
}
