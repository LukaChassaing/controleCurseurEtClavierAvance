class Monitor {
  int x, y, w, h;
  int currentValue, targetValue;
  color backgroundColor;
  Channel sourceChannel;
  CheckBox showGraph;
  Textlabel label;
  Toggle toggle;

  Monitor(Channel sourceChannel, int x, int y, int w, int h) {
    this.sourceChannel = sourceChannel;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.currentValue = 0;
    this.backgroundColor = color(255);

    // Create GUI elements
    showGraph = controlP5.addCheckBox("showGraph" + sourceChannel.name, x + 16, y + 32);
    showGraph.addItem("GRAPH" + sourceChannel.name, 0);
    showGraph.activate(1);
    showGraph.setColorForeground(sourceChannel.drawColor);
    showGraph.setColorActive(color(180));
    showGraph.setColorBackground(color(0));

    toggle = showGraph.getItem(0);
    toggle.setLabel("GRAPH");

    label = new Textlabel(controlP5, sourceChannel.name.toUpperCase(), x + 12, y + 15);
    label.setColorValue(0);
  }

  void update() {
    sourceChannel.graphMe = showGraph.getItem(0).getValue() == 0;
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    // Draw background
    noStroke();
    fill(backgroundColor);
    rect(0, 0, w, h);

    // Draw border line
    strokeWeight(1);
    stroke(220);
    line(w - 1, 0, w - 1, h);

    // Draw bar graph
    if (!sourceChannel.points.isEmpty()) {
      Point targetPoint = sourceChannel.points.get(sourceChannel.points.size() - 1);
      targetValue = round(map(targetPoint.value, sourceChannel.minValue, sourceChannel.maxValue, 0, h));

      if (scaleMode.equals("Global") && sourceChannel.allowGlobal) {
        targetValue = (int) map(targetPoint.value, 0, globalMax, 0, h);
      }

      // Calculate the new position with easing
      currentValue += round((targetValue - currentValue) * 0.08);

      // Draw bar
      noStroke();
      fill(sourceChannel.drawColor);
      rect(0, h - currentValue, w, h);
    }

    // Draw checkbox matte
    noStroke();
    fill(240, 150);
    rect(10, 10, w - 20, 40);

    popMatrix();
    label.draw();
  }
}
