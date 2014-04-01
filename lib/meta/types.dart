part of dartling;

class AttributeTypes extends Entities<AttributeType> {

}

class AttributeType extends ConceptEntity<AttributeType> {

  String base; 
  int length;

  Domain domain;

  AttributeType(this.domain, String typeCode) {
    if (typeCode == 'Email') {
      base = 'String';
      length = 48;
    } else if (typeCode == 'Uri') {
      base = 'Uri';
      length = 80;
    } else if (typeCode == 'Other') {
      base = 'dynamic';
      length = 64;
    } else {
      base = typeCode;
    }
    code = typeCode;
    domain.types.add(this);
  }

}
