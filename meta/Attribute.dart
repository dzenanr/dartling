
class Attribute extends Property {
  
  var init;
  int increment;
  int sequence;
  
  Type parentType;
  
  Attribute(Concept parentConcept, String code) : super(parentConcept, code) {
    parentConcept.childAttributes.add(this);
    // default type is String
    parentType = parentConcept.parentModel.parentDomain.childTypes.getEntity('String');
  }
  
}
