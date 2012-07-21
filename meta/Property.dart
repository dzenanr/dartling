
abstract class Property extends Entity<Property> {

  String min = '0';
  String max = '1';
  bool _id = false;
  bool update = true;

  Concept sourceConcept;

  Property(this.sourceConcept, String code) {
    super.code = code;
  }

  bool get maxMany() {
    var minmax = max.trim();
    if (minmax != '0' && minmax != '1') {
      return true;
    }
    return false;
  }

  bool get id() => _id;
  set id(bool i) {
    _id = i;
    if (i) {
      min = '1';
      max = '1';
    }
  }

}
