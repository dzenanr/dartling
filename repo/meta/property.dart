
abstract class Property extends ConceptEntity<Property> {

  String minc = '0';
  String maxc = '1';
  bool _id = false;
  bool update = true;
  bool sensitive = false;

  Concept sourceConcept;

  Property(this.sourceConcept, String propertyCode) {
    super.code = propertyCode;
  }

  bool get maxMany() => maxc != '0' && maxc != '1' ? true : false;

  bool get identifier() => _id;
  set identifier(bool i) {
    _id = i;
    if (i) {
      minc = '1';
      maxc = '1';
      update = false;
    }
  }

  bool get required() => minc == '1' ? true : false;
  set required(bool r) {
    r ? minc = '1' : minc = '0';
  }

}
