#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#define FIREBASE_HOST "iot-example-eb8c1-default-rtdb.europe-west1.firebasedatabase.app"
#define FIREBASE_AUTH "U7v0SE5XuRmVctW0ttORdwbrendU7wC9jy1QD1ZC"
#define WIFI_SSID "Tarek_Mahrous"
#define WIFI_PASSWORD "Tarek_15031967_Mahrous"

int tempPin = A0;
int ledPin = 16;
int tempVal;
void setup() {
  pinMode(ledPin, OUTPUT); 
  Serial.begin(9600);
  WiFi.mode(WIFI_STA);
  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    Serial.print(WiFi.status());
    delay(1000);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}
bool light;

void loop(){ 
  tempVal = analogRead(tempPin);
  float cel = ( tempVal*330)/1023;
  float farh = cel* 1.8 + 32.0;
  Firebase.setFloat("Temp", cel);
  Firebase.setFloat("farh", farh);
  
  light= Firebase.getBool("SwitchState");
    // handle error
  if (Firebase.failed()) {
    Serial.print("error");
      Serial.println(Firebase.error());  
      return;
  }
  if(light==true)
  {
    Serial.println("light on");
    digitalWrite(ledPin, HIGH);
  }
    else if(light==false)
  {
    Serial.println("light off");
    digitalWrite(ledPin, LOW);
  }
  }

 
