
class Attribute extends Property {

  bool guid = false;
  var init;
  int increment;
  int sequence;

  Type type;

  Attribute(Concept parentConcept, String code) : super(parentConcept, code) {
    parentConcept.attributes.add(this);
    // default type is String
    type = parentConcept.model.domain.types.getEntity('String');
  }

}
