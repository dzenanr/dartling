
class Attribute extends Property {

  bool guid = false;
  var init;
  int increment;
  int sequence;
  bool derive = false;
  bool essential = true;

  Type type;

  Attribute(Concept sourceConcept, String code) : super(sourceConcept, code) {
    sourceConcept.attributes.add(this);
    // default type is String
    type = sourceConcept.model.domain.getType('String');
  }

}
