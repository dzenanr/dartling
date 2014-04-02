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
    } else if (typeCode == 'Uri') {
      base = typeCode;
      length = 80;
    } else if (typeCode == 'Email') {
      base = 'String';
      length = 48;
    } else if (typeCode == 'Telephone') {
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
  
  validateValue(String value) {
    if (code == 'DateTime') {
      try {
        DateTime.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (code == 'num') {
      try {
        num.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (code == 'int') {
      try {
        int.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (code == 'double') {
      try {
        double.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (code == 'bool') {
      if (value != 'true' && value != 'false') {
        return false;
      }
    } else if (code == 'DateTime') {
      try {
        DateTime.parse(value);
      } on FormatException catch (e) {
        return false;
      }
    } else if (code == 'Uri') {
      var uri = Uri.parse(value);
      if (uri.host == '') {
        return false;
      }
    } else if (code == 'Email') {
      return isEmail(value);
    }
    return true;
  }

}
