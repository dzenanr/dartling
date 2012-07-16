
class Oid implements Comparable {
  
  static int increment = 0;
  
  int timeStamp;
  
  Oid() {
    Date nowDate = new Date.now();
    int nowValue = nowDate.millisecondsSinceEpoch;  // versus nowDate.millisecond ?
    timeStamp = nowValue + increment++;
  }
  
  /**
   * Compares two oids based on unique numbers. If the result is less than 0
   * then the first entity is less than the second, if it is equal to 0 they
   * are equal and if the result is greater than 0 then the first is greater
   * than the second.
   */
  int compareTo(Oid oid) {   
    return timeStamp.compareTo(oid.timeStamp);
  }
  
  String toString() {
    return timeStamp.toString();
  }
  
}