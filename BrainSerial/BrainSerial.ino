#include <Brain.h>

// Set up the brain parser, pass it the hardware serial object you want to listen on.
Brain brain(Serial);

void setup() {
  // Start the hardware serial.
  Serial.begin(9600);
}

void loop() {
  // Update the brain object with the latest data from the Neurosky headset.
  if (brain.update()) {
    // If the update was successful, print the CSV data to the serial port.
    Serial.print(brain.readCSV());
    Serial.print("\n");
  }
}
