int ti;

#include <LiquidCrystal.h>

const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

int calib;
int calib1;
int calib2;

void setup()
{
  Serial.begin(9600);
  lcd.begin(16,2);  /* Initialize 16x2 LCD */
  lcd.clear();  /* Clear the LCD */
  calib=analogRead(A0);
  calib1=analogRead(A1);
  calib2=analogRead(A2);
  Serial.print(calib);
  Serial.print("\t");
  Serial.print(calib1);
  Serial.print("\t");
  Serial.println(calib2);
  digitalWrite(A5,LOW);
}

void loop()
{
  while(((analogRead(A0)-calib)<100) && ((analogRead(A1)-calib1)<100) && ((analogRead(A2)-calib2)<100));
  ti=millis();
  delay(2000);
  while(((analogRead(A0)-calib)<100) && ((analogRead(A1)-calib1)<100) && ((analogRead(A2)-calib2)<100));
  int fin = millis()-ti;
  lcd.setCursor(0,0);
  lcd.print(String(fin));
  Serial.println(fin);
  while(true);
}
