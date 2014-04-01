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

}
