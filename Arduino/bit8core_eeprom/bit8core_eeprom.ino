#include <EEPROM.h>
#include <TimerOne.h>

int addr = 0;
int data = 0;
int rw = 0;

int stat = 0;
boolean toggle1 = 0;

void setup()
{
  //Program in opcode

  Timer1.initialize(500000);
  Timer1.attachInterrupt(inter);
  
  EEPROM.update(0,128);
  EEPROM.update(1,64);
  EEPROM.update(2,129);
  EEPROM.update(3,65);
  EEPROM.update(4,240);
  EEPROM.update(5,241);
  EEPROM.update(6,72);
  EEPROM.update(7,210);
  EEPROM.update(8,162);
  EEPROM.update(9,66);
  EEPROM.update(10,10);

  EEPROM.update(64,56);
  EEPROM.update(65,60);
    
  Serial.begin(9600);
  pinMode(2,OUTPUT);
  pinMode(3,INPUT);
  pinMode(A0,INPUT);
  pinMode(A1,INPUT);
  pinMode(A2,INPUT);
  pinMode(A3,INPUT);
  pinMode(A4,INPUT);
  pinMode(A5,INPUT);
  pinMode(4,INPUT);
  pinMode(5,INPUT);

  Serial.println("Enter");

  attachInterrupt(digitalPinToInterrupt(2),prg,RISING);
}

void inter()
{
  if (toggle1)
  {
    digitalWrite(2,HIGH);
    toggle1 = 0;
  }
  else
  {
    digitalWrite(2,LOW);
    toggle1 = 1;
  }
}

void prg()
{
  addr = digitalRead(5)*128 + digitalRead(4)*64 + digitalRead(A5)*32 + digitalRead(A4)*16 + digitalRead(A3)*8 + digitalRead(A2)*4 + digitalRead(A1)*2 + digitalRead(A0)*1;
  Serial.print(addr);
  Serial.print("\t");
  rw = digitalRead(3);
  if(rw)
  {
    data = digitalRead(13)*128 + digitalRead(12)*64 + digitalRead(11)*32 + digitalRead(10)*16 + digitalRead(9)*8 + digitalRead(8)*4 + digitalRead(7)*2 + digitalRead(6)*1;
    EEPROM.write(addr,data);
  }
  else
  {
    data = EEPROM.read(addr);
    int p13 = data / 128;    
    if(p13)
      digitalWrite(13,HIGH);
    else
      digitalWrite(13,LOW);
    
    data = data % 128;
    int p12 = data / 64;
    if(p12)
      digitalWrite(12,HIGH);
    else
      digitalWrite(12,LOW);
    
    data = data % 64;
    int p11 = data / 32;
    if(p11)
      digitalWrite(11,HIGH);
    else
      digitalWrite(11,LOW);

    data = data % 32;
    int p10 = data / 16;
    if(p10)
      digitalWrite(10,HIGH);
    else
      digitalWrite(10,LOW);

    data = data % 16;
    int p9 = data / 8;
    if(p9)
      digitalWrite(9,HIGH);
    else
      digitalWrite(9,LOW);

    data = data % 8;
    int p8 = data / 4;
    if(p8)
      digitalWrite(8,HIGH);
    else
      digitalWrite(8,LOW);

    data = data % 8;
    int p7 = data / 4;
    if(p7)
      digitalWrite(7,HIGH);
    else
      digitalWrite(7,LOW);

    data = data % 4;
    int p6 = data / 2;
    if(p6)
      digitalWrite(6,HIGH);
    else
      digitalWrite(6,LOW);
  }
  Serial.print(data);
  Serial.print("\t");
  Serial.println(rw);
}

void loop()
{
  
}
