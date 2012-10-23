part of dartling;

abstract class Property extends ConceptEntity<Property> {

  String minc = '0';
  String maxc = '1';
  bool _id = false;
  bool essential = false;
  bool update = true;
  bool sensitive = false;

  Concept sourceConcept;

  Property(this.sourceConcept, String propertyCode) {
    super.code = propertyCode;
  }

  bool get maxMany => maxc != '0' && maxc != '1' ? true : false;

  bool get identifier => _id;
  set identifier(bool id) {
    _id = id;
    if (id) {
      minc = '1';
      maxc = '1';
      essential = true;
      update = false;
    }
  }

  bool get required => minc == '1' ? true : false;
  set required(bool req) {
    req ? minc = '1' : minc = '0';
  }

}
