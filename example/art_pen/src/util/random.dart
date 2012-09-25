
double randomDouble(double max) {
  double randomDouble = new Random().nextDouble() * 100;
  return randomDouble > max ? max : randomDouble;
}

randomInt(int max) => new Random().nextInt(max);

randomListElement(List list) => list[randomInt(list.length - 1)];

randomPoint(double maxX, double maxY) =>
    new Point(randomDouble(maxX), randomDouble(maxY));

randomSign(int spread) {
  int result = 1;
  if (randomInt(spread) == 0) {
    result = -1;
  }
  return result;
}

randomBool(int spread) {
  bool result = true;
  if (randomInt(spread) == 0) {
    result = false;
  }
  return result;
}
