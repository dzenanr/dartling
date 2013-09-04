part of dartling;

class Oid implements Comparable {

  static int _increment = 0;

  int _timeStamp;

  Oid() {
    DateTime nowDate = new DateTime.now();
    int nowValue = nowDate.millisecondsSinceEpoch;  // versus nowDate.millisecond ?
    _timeStamp = nowValue + _increment++;
  }

  Oid.ts(int timeStamp) {
    _timeStamp = timeStamp;
  }

  int get timeStamp => _timeStamp;
  
  int get hashCode => _timeStamp.hashCode;

  /**
   * Two oids are equal if their time stamps are equal.
   */
  bool equals(Oid oid) {
    if (_timeStamp == oid.timeStamp) {
      return true;
    }
    return false;
  }

  /**
   * == see:
   * https://www.dartlang.org/docs/dart-up-and-running/contents/ch02.html#op-equality
   *
   * Evolution:
   *
   * If x===y, return true.
   * Otherwise, if either x or y is null, return false.
   * Otherwise, return the result of x.equals(y).
   *
   * The newest spec is:
   * a) if either x or y is null, do identical(x, y)
   * b) otherwise call operator ==
   */
  bool operator ==(Object other) {
    if (other is Oid) {
      Oid oid = other;
      if (identical(this, oid)) {
        return true;
      } else {
        if (this == null || oid == null) {
          return false;
        } else {
          return equals(oid);
        }
      }
    } else {
      return false;
    }
  }

  /*
  bool operator ==(Object other) {
    if (other is Oid) {
      Oid oid = other;
      if (this == null && oid == null) {
        return true;
      } else if (this == null || oid == null) {
        return false;
      } else if (identical(this, oid)) {
        return true;
      } else {
        return equals(oid);
      }
    } else {
      return false;
    }
  }
  */

  /**
   * Compares two oids based on unique numbers. If the result is less than 0
   * then the first entity is less than the second, if it is equal to 0 they
   * are equal and if the result is greater than 0 then the first is greater
   * than the second.
   */
  int compareTo(Oid oid) => _timeStamp.compareTo(oid._timeStamp);

  String toString() => _timeStamp.toString();

}