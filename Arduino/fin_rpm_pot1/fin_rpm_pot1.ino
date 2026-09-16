#include<Wire.h>
int pinCS = 10;
int x1 = 0;
int y1 = 0;
int temp;
int c;
int c1,c2,c3,c4;

const int dataIN1 = 2;
unsigned long prevmillis1;
unsigned long duration1;
unsigned long refresh1;
const int dataIN2 = 3;
unsigned long prevmillis2;
unsigned long duration2;
unsigned long refresh2;
const int dataIN3 = 4;
unsigned long prevmillis3;
unsigned long duration3;
unsigned long refresh3;
const int dataIN4 = 5;
unsigned long prevmillis4;
unsigned long duration4;
unsigned long refresh4;

int rpm1;
int rpm2;
int rpm3;
int rpm4;

boolean currentstate1;
boolean prevstate1;
boolean currentstate2;
boolean prevstate2;
boolean currentstate3;
boolean prevstate3;
boolean currentstate4;
boolean prevstate4;

void setup()
{
  pinMode(dataIN1, INPUT);
  pinMode(dataIN2, INPUT);
  pinMode(dataIN3, INPUT);
  pinMode(dataIN4, INPUT);
  pinMode(pinCS, OUTPUT);
  prevmillis1 = 0;
  prevstate1 = LOW;
  prevmillis2 = 0;
  prevstate2 = LOW;
  prevmillis3 = 0;
  prevstate3 = LOW;
  prevmillis4 = 0;
  prevstate4 = LOW;
  Serial.begin(9600);
  Wire.begin();
}


void loop()
{
  // RPM Measurement
  currentstate1 = digitalRead(dataIN1);
  if ( prevstate1 != currentstate1)
  {
    if(currentstate1 == HIGH)
    {
      c1+=1;
      if ( c1==2 )
      {
        duration1 = ( millis() - prevmillis1 );
        rpm1 = (60000 / duration1);
        prevmillis1 = millis();
        c1=0;
      }
    }
  }
  prevstate1 = currentstate1;


  currentstate2 = digitalRead(dataIN2);
  if ( prevstate2 != currentstate2)
  {
    if ( currentstate2 == HIGH )
    {
      c2+=1;
      if(c2==4)
      {
        duration2 = ( millis() - prevmillis2 );
        rpm2 = (60000 / duration2);
        prevmillis2 = millis();
        c2=0;
      }
    }
    c+=1;
  }
  prevstate2 = currentstate2;


  currentstate3 = digitalRead(dataIN3);
  if ( prevstate3 != currentstate3)
  {
    if ( currentstate3 == HIGH )
    {
      c3+=1;
      if(c3==8)
      {
        duration3 = ( millis() - prevmillis3 );
        rpm3 = (60000 / duration3);
        prevmillis3 = millis();
        c3=0;
      }
    }

  }
  prevstate3 = currentstate3;


  currentstate4 = digitalRead(dataIN4);
  if ( prevstate4 != currentstate4)
  {
    c4+=1;
    if ( currentstate4 == HIGH )
    {
      duration4 = ( millis() - prevmillis4 );
      rpm4 = (60000 / duration4);
      prevmillis4 = millis();
    }

  }
  prevstate4 = currentstate4;
  int a=analogRead(A0);
  temp=a*500/1023;
  Serial.print(rpm1);
  Serial.print(" ");
  Serial.print(rpm2);
  Serial.print(" ");
  Serial.print(rpm3);
  Serial.print(" ");
  Serial.print(rpm4);
  Serial.print(" ");
  Serial.print(0.2875*rpm2*2*3.14151);
  Serial.print(" ");
  Serial.print(c*0.2875*3.1415926535);
  Serial.print(" ");
  Serial.print(temp);
  Serial.print(" ");
  Wire.requestFrom(8,1);
  int rec = Wire.read();
  Serial.println(rec);
  delay(250);
}
