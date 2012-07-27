
abstract class Property extends Entity<Property> {

  String min = '0';
  String max = '1';
  bool _id = false;
  bool update = true;

  Concept sourceConcept;

  Property(this.sourceConcept, String code) {
    super.code = code;
  }

  bool get maxMany() => max != '0' && max != '1' ? true : false;

  bool get id() => _id;
  set id(bool i) {
    _id = i;
    if (i) {
      min = '1';
      max = '1';
    }
  }

  bool get required() => min == '1' ? true : false;
  set required(bool r) {
    r ? min = '1' : min = '0';
  }

}
