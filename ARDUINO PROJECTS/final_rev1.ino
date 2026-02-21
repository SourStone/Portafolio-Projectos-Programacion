
#include <DHT11.h>

DHT11 dht11(3);

char c = '0';

int MOTOROA = 7;
int CSMS = A0;
int LDR = A1;
unsigned long tiempo = 0;
int deltaT = 2000;

void setup() {
  Serial.begin(9600);  // serial port setup// set the analog reference to 3.3V
  pinMode(MOTOROA, OUTPUT);
  digitalWrite(MOTOROA, HIGH);
}

void loop() {
  if(Serial.available() > 0) {
    c = Serial.read();
    if(c == '0') digitalWrite(7,HIGH);
    if(c == '1') digitalWrite(7,LOW);
  }
  
  //imprimir datos casa 2 segundos
  if (millis() - tiempo > deltaT) {
    tiempo = millis();
    int temperature = 0;
    int humidity = 0;

    //lectura de sensores
    int csmsRead = analogRead(CSMS);
    int ldrRead = analogRead(LDR);
    int result = dht11.readTemperatureHumidity(temperature, humidity);

    //impresion de string
    Serial.print(csmsRead);
    Serial.print("-");
    Serial.print(ldrRead);
    Serial.print("-");
    Serial.print(temperature);
    Serial.print("-");
    Serial.print(humidity);
    Serial.print("_");
    Serial.println();
  }
  
  
}
