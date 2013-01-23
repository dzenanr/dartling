part of dartling;

class Attributes extends Entities<Property> {

}

class Attribute extends Property {

  bool guid = false;
  var init;
  int increment;
  int sequence;
  bool _derive = false;

  AttributeType type;

  Attribute(Concept sourceConcept, String attributeCode) :
    super(sourceConcept, attributeCode) {
    sourceConcept.attributes.add(this);
    // default type is String
    type = sourceConcept.model.domain.getType('String');
  }

  bool get derive => _derive;
  set derive(bool derive) {
    _derive = derive;
    if (_derive) {
      update = false;
    }
  }

}
