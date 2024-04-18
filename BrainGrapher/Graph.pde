class Graph {
  int x, y, w, h;
  int pixelsPerSecond;
  color gridColor;
  int gridX;
  int originalW, originalX;
  long leftTime, rightTime, gridTime;
  boolean scrollGrid;
  String renderMode;
  float gridSeconds;
  Slider pixelSecondsSlider;
  RadioButton renderModeRadio;
  RadioButton scaleRadio;

  Graph(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    pixelsPerSecond = 50;
    gridColor = color(0);
    gridSeconds = 1; // seconds per grid line
    scrollGrid = false;

    originalW = w;
    originalX = x;

    // Set up GUI controls
    pixelSecondsSlider = controlP5.addSlider("PIXELS PER SECOND", 10, width, 50, 16, 16, 100, 10);
    pixelSecondsSlider.setColorForeground(color(180));
    pixelSecondsSlider.setColorActive(color(180));
    pixelSecondsSlider.setColorValueLabel(color(255));

    renderModeRadio = controlP5.addRadioButton("RENDER MODE", 16, 36);
    renderModeRadio.setColorForeground(color(255));
    renderModeRadio.setColorActive(color(0));
    renderModeRadio.setColorBackground(color(180));
    renderModeRadio.setSpacingRow(4);
    renderModeRadio.addItem("Lines", 1);
    renderModeRadio.addItem("Curves", 2);
    renderModeRadio.addItem("Shaded", 3);
    renderModeRadio.addItem("Triangles", 4);
    renderModeRadio.activate(0);

    scaleRadio = controlP5.addRadioButton("SCALE MODE", 104, 36);
    scaleRadio.setColorForeground(color(255));
    scaleRadio.setColorActive(color(0));
    scaleRadio.setColorBackground(color(180));
    scaleRadio.setSpacingRow(4);
    scaleRadio.addItem("Local Maximum", 1);
    scaleRadio.addItem("Global Maximum", 2);
    scaleRadio.activate(0);
  }

  void update() {
    // Update pixels per second from GUI slider
    pixelsPerSecond = round(pixelSecondsSlider.getValue());

    // Update render mode from GUI radio buttons
    switch (round(renderModeRadio.getValue())) {
      case 1:
        renderMode = "Lines";
        break;
      case 2:
        renderMode = "Curves";
        break;
      case 3:
        renderMode = "Shaded";
        break;
      case 4:
        renderMode = "Triangles";
        break;
    }

    // Update scale mode from GUI radio buttons
    switch (round(scaleRadio.getValue())) {
      case 1:
        scaleMode = "Local";
        break;
      case 2:
        scaleMode = "Global";
        break;
    }

    // Smooth drawing kludge
    w = originalW;
    x = originalX;

    w += pixelsPerSecond * 2;
    x -= pixelsPerSecond;

    // Update time bounds based on pixels per second
    rightTime = System.currentTimeMillis();
    leftTime = rightTime - (w / pixelsPerSecond) * 1000;
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    // Draw background
    fill(220);
    rect(0, 0, w, h);

    // Draw grid lines
    strokeWeight(1);
    stroke(255);

    if (scrollGrid) {
      // Start from the first whole second and work right
      gridTime = (rightTime / (long) (1000 * gridSeconds)) * (long) (1000 * gridSeconds);
    } else {
      gridTime = rightTime;
    }

    while (gridTime >= leftTime) {
      gridX = (int) mapLong(gridTime, leftTime, rightTime, 0L, (long) w);
      line(gridX, 0, gridX, h);
      gridTime -= (long) (1000 * gridSeconds);
    }

    int gridY = h;
    while (gridY >= 0) {
      gridY -= pixelsPerSecond * gridSeconds;
      line(0, gridY, w, gridY);
    }

    // Draw each channel
    noFill();
    if (renderMode.equals("Shaded") || renderMode.equals("Triangles")) noStroke();
    if (renderMode.equals("Curves") || renderMode.equals("Lines")) strokeWeight(2);

    for (Channel channel : channels) {
      if (channel.graphMe) {
        // Draw the graph line
        if (renderMode.equals("Lines") || renderMode.equals("Curves")) stroke(channel.drawColor);

        if (renderMode.equals("Shaded") || renderMode.equals("Triangles")) {
          noStroke();
          fill(channel.drawColor, 120);
        }

        if (renderMode.equals("Triangles")) {
          beginShape(TRIANGLES);
        } else {
          beginShape();
        }

        if (renderMode.equals("Curves") || renderMode.equals("Shaded")) vertex(0, h);

        for (Point point : channel.points) {
          // Check bounds
          if (point.time >= leftTime && point.time <= rightTime) {
            int pointX = (int) mapLong(point.time, leftTime, rightTime, 0L, (long) w);
            int pointY;

            if (scaleMode.equals("Global") && channels.length > 3) {
              // Global scale
              pointY = (int) map(point.value, 0, globalMax, h, 0);
            } else {
              // Local scale
              pointY = (int) map(point.value, channel.minValue, channel.maxValue, h, 0);
            }

            if (renderMode.equals("Curves")) {
              curveVertex(pointX, pointY);
            } else {
              vertex(pointX, pointY);
            }
          }
        }

        if (renderMode.equals("Curves") || renderMode.equals("Shaded")) vertex(w, h);
        if (renderMode.equals("Lines") || renderMode.equals("Curves") || renderMode.equals("Triangles"))
          endShape();
        if (renderMode.equals("Shaded")) endShape(CLOSE);
      }
    }

    popMatrix();

    // Draw GUI background matte
    noStroke();
    fill(255, 150);
    rect(10, 10, 195, 81);
  }
}
