#include <SPI.h>
#include <SD.h>

const int chipSelect = 4;

File dataFile;

void setup()
{
  Serial.begin(9600);
  while(!Serial)
  {
    
  }
  Serial.println("Initializing SD card ....");
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    while (1);
  }
  Serial.println("card initialized.");
}

void loop()
{
  dataFile = SD.open("datalog.txt", FILE_WRITE);
  int x = analogRead(A0);
  String dataString = String(x);
  if (dataFile) {
    dataFile.println(dataString);
    dataFile.close();
    // print to the serial port too:
    Serial.println(dataString);
  }
  // if the file isn't open, pop up an error:
  else {
    Serial.println("error opening datalog.txt");
  }
}
