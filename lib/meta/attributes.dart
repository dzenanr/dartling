part of dartling;

class Attributes extends Entities<Property> {

  List<Attribute> toList({bool growable: true}) {
    var attributeList = new List<Attribute>();
    for (var attribute in this) {
      attributeList.add(attribute);
    }
    return attributeList;
  }

}

class Attribute extends Property {

  bool guid = false;
  var init;
  int increment;
  int sequence;
  bool _derive = false;
  int length;

  AttributeType _type;

  Attribute(Concept sourceConcept, String attributeCode) :
    super(sourceConcept, attributeCode) {
    sourceConcept.attributes.add(this);
    // default type is String
    type = sourceConcept.model.domain.getType('String');
  }
  
  AttributeType get type => _type;
  set type(AttributeType attributeType) {
    _type = attributeType;
    if (attributeType != null && length == null) {
      length = attributeType.length;
    }
  }

  bool get derive => _derive;
  set derive(bool derive) {
    _derive = derive;
    if (_derive) {
      update = false;
    }
  }

}
