int prevmillisa = 0;
int prevmillisb = 0;
int trpm;
int rpm;

void setup()
{
  pinMode(2,INPUT_PULLUP);
  pinMode(3,INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2),inta,FALLING);
  attachInterrupt(digitalPinToInterrupt(3),intb,FALLING);
}

void inta()
{
  int ti = millis();
  trpm = (ti-prevmillisa)/60000;
  if( (ti - prevmillisb) > (prevmillisb - prevmillisa) )
  {
    rpm = trpm;
  }
  else
  {
    rpm = -1* trpm;
  }
}

void intb()
{
  prevmillisb = millis();
}

void loop()
{
  Serial.println(rpm);
}
