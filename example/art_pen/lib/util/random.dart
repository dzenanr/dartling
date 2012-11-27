part of art_pen;

double randomDouble(double max) {
  double randomDouble = new Random().nextDouble() * max;
  return randomDouble > max ? max : randomDouble;
}

int randomInt(int max) => new Random().nextInt(max);

randomListElement(List list) => list[randomInt(list.length - 1)];

String randomColor() => randomListElement(colorList());
String randomColorCode() => colorMap()[randomColor()];

Map randomPoint(double maxX, double maxY) {
  var x = randomDouble(maxX);
  var y = randomDouble(maxY);
  var point = {'x': x, 'y': y};
  return point;
}

int randomSign(int spread) {
  int result = 1;
  if (randomInt(spread) == 0) {
    result = -1;
  }
  return result;
}

bool randomBool(int spread) {
  bool result = true;
  if (randomInt(spread) == 0) {
    result = false;
  }
  return result;
}
