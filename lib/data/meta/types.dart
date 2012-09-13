
class Types extends Entities<Type> {

}

class Type extends ConceptEntity<Type> {

  String base;
  int length;

  Domain domain;

  Type(this.domain, String typeCode) {
    super.code = typeCode;
    base = typeCode;
    domain.types.add(this);
  }

}
