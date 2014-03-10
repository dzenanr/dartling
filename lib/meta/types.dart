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
    } else if (typeCode == 'Other') {
      base = 'dynamic';
    } else {
      base = typeCode;
    }
    code = typeCode;
    domain.types.add(this);
  }

}
