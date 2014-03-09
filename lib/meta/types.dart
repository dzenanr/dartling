part of dartling;

class AttributeTypes extends Entities<AttributeType> {

}

class AttributeType extends ConceptEntity<AttributeType> {

  String origin; 
  int length;

  Domain domain;

  AttributeType(this.domain, String typeCode) {
    if (typeCode == 'Email') {
      code = 'String';
    } else if (typeCode == 'Other') {
      code = 'dynamic';
    } else {
      code = typeCode;
    }
    origin = typeCode;
    domain.types.add(this);
  }

}
