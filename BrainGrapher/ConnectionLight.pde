class ConnectionLight {
  int x, y, diameter;
  int currentColor;
  int goodColor = color(0, 255, 0);
  int badColor = color(255, 255, 0);
  int noColor = color(255, 0, 0);
  Textlabel label;
  Textlabel packetsReceivedLabel;

  ConnectionLight(int x, int y, int diameter) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;

    // Set up the text labels
    label = new Textlabel(controlP5, "CONNECTION QUALITY", 32, 11, 200, 30);
    label.setMultiline(true);
    label.setColorValue(color(0));

    packetsReceivedLabel = new Textlabel(controlP5, "PACKETS RECEIVED: 0", 5, 35, 200, 30);
    packetsReceivedLabel.setMultiline(false);
    packetsReceivedLabel.setColorValue(color(0));
  }

  void update() {
    // Update the current color based on the latest connection value
    int latestConnectionValue = channels[0].points.isEmpty() ? 200 : channels[0].getLatestPoint().value;

    if (latestConnectionValue == 200) currentColor = noColor;
    else if (latestConnectionValue < 200) currentColor = badColor;
    else currentColor = goodColor;

    // Update the packets received label
    packetsReceivedLabel.setText("PACKETS RECEIVED: " + packetCount);
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    // Draw the background
    noStroke();
    fill(255, 150);
    rect(0, 0, 132, 50);

    // Draw the connection light
    noStroke();
    fill(currentColor);
    ellipseMode(CORNER);
    ellipse(5, 4, diameter, diameter);

    // Draw the labels
    label.draw();
    packetsReceivedLabel.draw();
    popMatrix();
  }
}
