part of dartling;

class AttributeTypes extends Entities<AttributeType> {

}

class AttributeType extends ConceptEntity<AttributeType> {

  String base;
  int length;

  Domain domain;

  AttributeType(this.domain, String typeCode) {
    super.code = typeCode;
    base = typeCode;
    domain.types.add(this);
  }

}
