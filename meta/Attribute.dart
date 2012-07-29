
class Attribute extends Property {

  bool guid = false;
  var init;
  num increment;
  int sequence;
  bool _derive = false;
  bool essential = true;

  Type type;

  Attribute(Concept sourceConcept, String code) : super(sourceConcept, code) {
    sourceConcept.attributes.add(this);
    // default type is String
    type = sourceConcept.model.domain.getType('String');
  }

  bool get derive() => _derive;
  set derive(bool derive) {
    _derive = derive;
    update = false;
  }

  //Concept get concept() => sourceConcept;

}
