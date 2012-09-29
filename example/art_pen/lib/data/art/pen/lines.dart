
// src/data/art/pen/lines.dart

class Line extends LineGen {

  Line(Concept concept) : super(concept);

  // begin: added by hand
  Line previousLine;

  Line.first(Concept concept, num beginX, num beginY) : super(concept) {
    this.beginX = beginX;
    this.beginY = beginY;
  }

  Line.next(Concept concept, Line lastLine) : super(concept) {
    beginX = lastLine.endX;
    beginY = lastLine.endY;
    previousLine = lastLine;
  }

  void set angle(num angle) {
    super.angle = angle;
    if (previousLine == null) {
      cumulativeAngle = angle;
    } else {
      cumulativeAngle = previousLine.cumulativeAngle + angle;
      if (cumulativeAngle > 360) {
        cumulativeAngle = cumulativeAngle - 360;
      }
    }
    Point endPoint = findEndPoint(beginX, beginY, cumulativeAngle, pixels);
    endX = endPoint.x;
    endY = endPoint.y;
  }

  void set pixels(num pixels) {
    super.pixels = pixels;
    Point endPoint = findEndPoint(beginX, beginY, cumulativeAngle, pixels);
    endX = endPoint.x;
    endY = endPoint.y;
  }

  Point findEndPoint(num beginX, num beginY, num beginAngle, num length) {
    var radian = (beginAngle * PI) / 180;
    var x = beginX + (length * cos(radian));
    var y = beginY + (length * sin(radian));
    return new Point(x, y);
  }

  void backOnBorder(int width, int height) {
    if (endX > width) {
      endX = width;
    } else if (endX < 0) {
      endX = 0;
    }
    if (endY > height) {
      endY = height;
    } else if (endY < 0) {
      endY = 0;
    }
  }
  // end: added by hand

}

class Lines extends LinesGen {

  Lines(Concept concept) : super(concept);

}

