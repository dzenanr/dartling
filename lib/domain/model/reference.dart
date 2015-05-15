part of dartling;

class Reference  {
  String parentOidString;
  String parentConceptCode;
  String entryConceptCode;
  
  Reference(this.parentOidString, this.parentConceptCode, this.entryConceptCode);
  
  Oid get oid {
    var parentTimeStamp;
    try {
      parentTimeStamp = int.parse(parentOidString);   
    } on FormatException catch (e) {
      throw new TypeException('${parentConceptCode} parent oid is not int: $e');
    }
    return new Oid.ts(parentTimeStamp); 
  }
 
  /*
  String toString() {
    String ref = 'parent oid: ${parentOidString}; ';
           ref = '${ref}parent concept: ${parentConceptCode}; ';
           ref = '${ref}entry concept: ${entryConceptCode}';
    return ref;
  */
  
  String toString() {
    return '${parentOidString}';
  }
}