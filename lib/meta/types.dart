part of dartling;

class AttributeTypes extends Entities<AttributeType> {

}

class AttributeType extends ConceptEntity<AttributeType> {

  String base; 
  int length;

  Domain domain;

  AttributeType(this.domain, String typeCode) {
    if (typeCode == 'String') {
      base = typeCode;
      length = 64;
    } else if (typeCode == 'num') {
      base = typeCode;
      length = 8;
    } else if (typeCode == 'int') {
      base = typeCode;
      length = 8;
    } else if (typeCode == 'double') {
      base = typeCode;
      length = 8;
    } else if (typeCode == 'bool') {
      base = typeCode;
      length = 8;
    } else if (typeCode == 'DateTime') {
      base = typeCode;
      length = 16;
    } else if (typeCode == 'Duration') {
      base = typeCode;
      length = 16;
    } else if (typeCode == 'Uri') {
      base = typeCode;
      length = 80;
    } else if (typeCode == 'Email') {
      base = 'String';
      length = 48;
    } else if (typeCode == 'Telephone') {
      base = 'String';
      length = 16;
    } else if (typeCode == 'PostalCode') {
      base = 'String';
      length = 16;
    } else if (typeCode == 'ZipCode') {
      base = 'String';
      length = 16;
    } else if (typeCode == 'Name') {
      base = 'String';
      length = 32;
    } else if (typeCode == 'Description') {
      base = 'String';
      length = 256;
    } else if (typeCode == 'Money') {
      base = 'double';
      length = 8;
    } else if (typeCode == 'dynamic') {
      base = typeCode;
      length = 64;
    } else if (typeCode == 'Other') {
      base = 'dynamic';
      length = 128;
    } else {
      base = typeCode;
      length = 96;
    }
    code = typeCode;
    domain.types.add(this);
  }
  
  bool isEmail(String email) {
    var regexp = new RegExp(
        r'\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b');
    return regexp.hasMatch(email);
  }
  
  validate(String value) {
    if (base == 'num') {
      try {
        num.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (base == 'int') {
      try {
        int.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (base == 'double') {
      try {
        double.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (base == 'bool') {
      if (value != 'true' && value != 'false') {
        return false;
      }
    } else if (base == 'DateTime') {
      try {
        DateTime.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (base == 'Duration') {
      // validation?
    } else if (base == 'Uri') {
      var uri = Uri.parse(value);
      if (uri.host == '') {
        return false;
      }
    } else if (code == 'Email') {
      return isEmail(value);
    }
    return true;
  }
  
  /**
   * Compares two values based on their type.
   * If the result is less than 0 then the first id is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compare(var value1, var value2) {
    var compare = 0;
    if (base == 'String') {
      compare = value1.compareTo(value2);
    } else if (base == 'num' ||
      base == 'int' || base == 'double') {
      compare = value1.compareTo(value2);
    } else if (base == 'bool') {
      compare = value1.toString().compareTo(value2.toString());
    } else if (base == 'DateTime') {
      compare = value1.compareTo(value2);
    } else if (base == 'Duration') {
      compare = value1.compareTo(value2);
    } else if (base == 'Uri') {
      compare = value1.toString().compareTo(value2.toString());
    } else {
      String msg = 'cannot compare then order on this type: ${code} type.';
      throw new OrderError(msg);
    }
    return compare;
  }

}
