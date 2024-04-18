class Channel {
  String name;
  int drawColor;
  String description;
  boolean graphMe;
  boolean relative;
  int maxValue;
  int minValue;
  ArrayList<Point> points;
  boolean allowGlobal;

  Channel(String name, int drawColor, String description) {
    this.name = name;
    this.drawColor = drawColor;
    this.description = description;
    this.allowGlobal = true;
    this.points = new ArrayList<Point>();
  }

  void addDataPoint(int value) {
    long time = System.currentTimeMillis();

    if (value > maxValue) maxValue = value;
    if (value < minValue) minValue = value;

    points.add(new Point(time, value));
  }

  Point getLatestPoint() {
    if (points.size() > 0) {
      return points.get(points.size() - 1);
    } else {
      return new Point(0, 0);
    }
  }
}
