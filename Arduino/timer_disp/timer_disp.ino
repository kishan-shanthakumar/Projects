#include <EEPROM.h>
//EEPROM.write(addr, val);
//value = EEPROM.read(address);

int rstate = 0;
int tstate = 0;
int run_hour_address = 0;
int run_min_address = 1;
int run_sec_address = 2;
int tot_hour_address = 3;
int tot_min_address = 4;
unsigned long val1;
unsigned long val2;
int buf = 0;

void setup()
{
  Serial.begin(2000000);
  attachInterrupt(digitalPinToInterrupt(2), checkstate, FALLING);
  attachInterrupt(3, motion, RISING);  
  pinMode(5,INPUT_PULLUP);
  pinMode(6,INPUT_PULLUP);
  pinMode(2,INPUT_PULLUP);
  pinMode(0,OUTPUT);
  pinMode(1,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(7,OUTPUT);
  pinMode(8,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);
  pinMode(A2,OUTPUT);
  pinMode(A3,OUTPUT);
  pinMode(A4,OUTPUT);
  pinMode(A5,OUTPUT);
  if ((EEPROM.read(run_hour_address) != 0) || (EEPROM.read(run_min_address) != 0) || (EEPROM.read(run_sec_address) != 0))
    preset();
}

void loop()
{
  delay(1000);
  val1 = map(analogRead(A0), 0, 1023, 0, 59);
  val2 = map(analogRead(A1), 0, 1023, 0, 59);
  if (digitalRead(5) == LOW)
    tstate ^= 1;
  Serial.print(val1);
  Serial.print(" ");
  Serial.print(val2);
  Serial.print(" ");
  Serial.print(rstate);
  Serial.print(" ");
  Serial.println(tstate);
  disp();
  if(rstate==1)
    ru();
  if(rstate==2)
    pause();
}

void preset()
{
  rstate = 0;
  if (EEPROM.read(run_hour_address) != 0)
  {
    val1 = EEPROM.read(run_hour_address);
    val2 = EEPROM.read(run_min_address);
    tstate = 1;
  }
  else
  {
    val1 = EEPROM.read(run_min_address);
    val2 = EEPROM.read(run_sec_address);
    tstate = 0;
  }
  while ((EEPROM.read(run_hour_address) != 0) || (EEPROM.read(run_min_address) != 0) || (EEPROM.read(run_sec_address) != 0))
  {
    disp();
  }
}

void checkstate()
{
  Serial.println("Here");
  if (digitalRead(5) == LOW)
    reset();
  else if (digitalRead(6) == LOW)
  {
    disptot();
  }
  else if (rstate == 0)
    rstate=1;
  else
    rstate=2;
}

void reset()
{
  Serial.println("Reset");
  EEPROM.update(run_hour_address, 0);
  EEPROM.update(run_min_address, 0);
  EEPROM.update(run_sec_address, 0);
  rstate=0;
  tstate=0;
}

void ru()
{
  Serial.println("Run");
  digitalWrite(9,HIGH);
  val1 = map(analogRead(A0), 0, 1023, 0, 59);
  val2 = map(analogRead(A1), 0, 1023, 0, 59);
  Serial.print(val1);
  Serial.print(" ");
  Serial.print(val2);
  Serial.print(" ");
  Serial.print(tstate);
  Serial.print(" ");
  Serial.println(!tstate);
  EEPROM.write(run_hour_address, val1 * tstate);
  EEPROM.write(run_min_address, (val2 * tstate + val1 * !tstate));
  EEPROM.write(run_sec_address, val2 * !tstate);
  unsigned long up = val1 * 60 * (60 ^ tstate);
  unsigned long down = val2 * (60 ^ tstate);
  Serial.println(up+down);
  unsigned long starttime = millis();
  Serial.println("Entering loop");
  while ( ( ((up + down) *1000) - (millis() - starttime - buf)) > 0)
  {
    if (tstate == 1)
    {
      EEPROM.update(run_min_address, (EEPROM.read(run_min_address) - ((millis() - starttime) / 60000)));
      EEPROM.update(run_hour_address, (EEPROM.read(run_hour_address) - ((millis() - starttime) / 3600000)));
      EEPROM.update(tot_min_address, (EEPROM.read(tot_min_address) + ((millis() - starttime) / 60000)));
      EEPROM.update(tot_hour_address, (EEPROM.read(tot_hour_address) + ((millis() - starttime) / 3600000)));
    }
    else
    {
      EEPROM.update(run_sec_address, (EEPROM.read(run_sec_address) - ((millis() - starttime) / 1000)));
      EEPROM.update(run_min_address, (EEPROM.read(run_min_address) - ((millis() - starttime) / 60000)));
      EEPROM.update(tot_min_address, (EEPROM.read(tot_min_address) + ((millis() - starttime) / 60000)));
    }
    disp();
  }
  Serial.println("Exiting loop");
  for (int i = 0; i < 3; i++)
  {
    EEPROM.write(i, 0);
  }
  rstate = 0;
  digitalWrite(9,LOW);
}

void pause()
{
  rstate = 0;
  Serial.println("Pause");
  int temp=millis();
  while (true)
  {
    disp();
  }
  buf += millis()-temp;
}

void motion()
{
  Serial.println("PIR");
  pausepir();
}

void pausepir()
{
  rstate=0;
  int temp=millis();
  while(digitalRead(3)==HIGH)
  {
    disp();
  }
  buf += millis()-temp;
}

void disptot()
{
  val1 = EEPROM.read(tot_hour_address);
  val2 = EEPROM.read(tot_min_address);
  delay(1000);
  disp();
}

void disp()
{
  if(tstate == 1)
  {
    digitalWrite(7, HIGH);
    digitalWrite(8, LOW);
  }
  if(tstate == 0)
  {
    digitalWrite(7, LOW);
    digitalWrite(8, HIGH);
  }
  digitalWrite(9, rstate);
  int dig[] = {val1 % 10,  int(val1 / 10),  val2 % 10,  int(val2 / 10)};
  for(int c=0;c<4;c++)
  {
    if(c==0)
    {
      digitalWrite(A2,HIGH);
      digitalWrite(A3,LOW);
      digitalWrite(A4,LOW);
      digitalWrite(A5,LOW);
    }
    if(c==1)
    {
      digitalWrite(A2,LOW);
      digitalWrite(A3,HIGH);
      digitalWrite(A4,LOW);
      digitalWrite(A5,LOW);
    }
    if(c==2)
    {
      digitalWrite(A2,LOW);
      digitalWrite(A3,LOW);
      digitalWrite(A4,HIGH);
      digitalWrite(A5,LOW);
    }
    if(c==3)
    {
      digitalWrite(A2,LOW);
      digitalWrite(A3,LOW);
      digitalWrite(A4,LOW);
      digitalWrite(A5,HIGH);
    }
    encode(dig[c]);
  }
}

void encode(int x)
{
  switch(x)
  {
    case 0:
      digitalWrite(0,LOW);
      digitalWrite(1,LOW);
      digitalWrite(4,LOW);
      digitalWrite(10,LOW);
      digitalWrite(11,LOW);
      digitalWrite(12,LOW);
      digitalWrite(13,HIGH);
      break;
    case 1:
      digitalWrite(0,HIGH);
      digitalWrite(1,LOW);
      digitalWrite(4,LOW);
      digitalWrite(10,HIGH);
      digitalWrite(11,HIGH);
      digitalWrite(12,HIGH);
      digitalWrite(13,HIGH);
      break;
    case 2:
      digitalWrite(0,LOW);
      digitalWrite(1,LOW);
      digitalWrite(4,HIGH);
      digitalWrite(10,LOW);
      digitalWrite(11,LOW);
      digitalWrite(12,HIGH);
      digitalWrite(13,LOW);
      break;
    case 3:
      digitalWrite(0,LOW);
      digitalWrite(1,LOW);
      digitalWrite(4,LOW);
      digitalWrite(10,LOW);
      digitalWrite(11,HIGH);
      digitalWrite(12,HIGH);
      digitalWrite(13,LOW);
      break;
    case 4:
      digitalWrite(0,HIGH);
      digitalWrite(1,LOW);
      digitalWrite(4,LOW);
      digitalWrite(10,HIGH);
      digitalWrite(11,HIGH);
      digitalWrite(12,LOW);
      digitalWrite(13,LOW);
      break;
    case 5:
      digitalWrite(0,LOW);
      digitalWrite(1,HIGH);
      digitalWrite(4,LOW);
      digitalWrite(10,LOW);
      digitalWrite(11,HIGH);
      digitalWrite(12,LOW);
      digitalWrite(13,LOW);
      break;
    case 6:
      digitalWrite(0,LOW);
      digitalWrite(1,HIGH);
      digitalWrite(4,LOW);
      digitalWrite(10,LOW);
      digitalWrite(11,LOW);
      digitalWrite(12,LOW);
      digitalWrite(13,LOW);
      break;
    case 7:
      digitalWrite(0,LOW);
      digitalWrite(1,LOW);
      digitalWrite(4,LOW);
      digitalWrite(10,HIGH);
      digitalWrite(11,HIGH);
      digitalWrite(12,HIGH);
      digitalWrite(13,HIGH);
      break;
    case 8:
      digitalWrite(0,LOW);
      digitalWrite(1,LOW);
      digitalWrite(4,LOW);
      digitalWrite(10,LOW);
      digitalWrite(11,LOW);
      digitalWrite(12,LOW);
      digitalWrite(13,LOW);
      break;
    case 9:
      digitalWrite(0,LOW);
      digitalWrite(1,LOW);
      digitalWrite(4,LOW);
      digitalWrite(10,LOW);
      digitalWrite(11,HIGH);
      digitalWrite(12,LOW);
      digitalWrite(13,LOW);
      break;
  }
}
