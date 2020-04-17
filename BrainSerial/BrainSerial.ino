#include <Brain.h>

// Arduino Brain Library - Brain Serial Test
// Description: Grabs brain data from the serial RX pin and sends CSV out over the TX pin (Half duplex.)
// More info: https://github.com/kitschpatrol/Arduino-Brain-Library
// Author: Eric Mika, 2010 revised in 2014
// Set up the brain parser, pass it the hardware serial object you want to listen on.
Brain brain(Serial);
void setup() {
    // Start the hardware serial.
    Serial.begin(9600);
}
void loop() {
    // Expect packets about once per second.
    // The .readCSV() function returns a string (well, char*) listing the most recent brain data, in the following format:
    // "signal strength, attention, meditation, delta, theta, low alpha, high alpha, low beta, high beta, low gamma, high gamma"
    // brain.update();
    boolean update();
    // String with most recent error.
    char* readErrors();
    // Returns comme-delimited string of all available brain data.
    // Sequence is as below.
     //char* readCSV();
    // Individual pieces of brain data.
    // uint8_t readSignalQuality();
    // uint8_t readAttention();
    // uint8_t readMeditation();
    // uint32_t* readPowerArray();
    // uint32_t readDelta();
    // uint32_t readTheta();
    // uint32_t readLowAlpha();
    // uint32_t readHighAlpha();
    // uint32_t readLowBeta();
    // uint32_t readHighBeta();
    // uint32_t readLowGamma();
    // uint32_t readMidGamma();
    if (brain.update()) {
      Serial.print(brain.readCSV());
      // Serial.print(brain.readErrors());
      // Serial.print("|");
      // Serial.print(brain.readSignalQuality());
      // Serial.print("|");
      // Serial.print(brain.readAttention());
      // Serial.print("|");
      // Serial.print(brain.readMeditation());
      // Serial.print("|");
      // //Serial.print("PowerArray : ");
      // //Serial.print(brain.readPowerArray());
      // //Serial.print("\n");
      // Serial.print(brain.readDelta());
      // Serial.print("|");
      // Serial.print(brain.readTheta());
      // Serial.print("|");
      // Serial.print(brain.readLowAlpha());
      // Serial.print("|");
      // Serial.print(brain.readHighAlpha());
      // Serial.print("|");
      // Serial.print(brain.readLowBeta());
      // Serial.print("|");
      // Serial.print(brain.readHighBeta());
      // Serial.print("|");
      // Serial.print(brain.readLowGamma());
      // Serial.print("|");
      // Serial.print(brain.readMidGamma());
      // Serial.print("|");
      Serial.print("\n");
    }
}
