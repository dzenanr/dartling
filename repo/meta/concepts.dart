
class Concepts extends Entities<Concept> {

}

class Concept extends ConceptEntity<Concept> {

  bool entry = true;
  bool abstract = false;

  String min = '0';
  String max = 'N';

  bool updateOid = false;
  bool updateCode = false;
  bool add = true;
  bool remove = true;

  String _codeInPlural;
  String description;

  Model model;

  Attributes attributes;
  Parents parents; // destination parent neighbors
  Children children; // destination child neighbors

  Parents sourceParents;
  Children sourceChildren;

  Concept(this.model, String conceptCode) {
    super.code = conceptCode;
    model.concepts.add(this);

    attributes = new Attributes();

    parents = new Parents();
    children = new Children();

    sourceParents = new Parents();
    sourceChildren = new Children();
  }

  Attribute getAttribute(String attributeCode) =>
      attributes.findByCode(attributeCode);

  Parent getDestinationParent(String parentCode) =>
      parents.findByCode(parentCode);
  Child getDestinationChild(String childCode) =>
      children.findByCode(childCode);

  Parent getSourceParent(String parentCode) =>
      sourceParents.findByCode(parentCode);
  Child getSourceChild(String childCode) =>
      sourceChildren.findByCode(childCode);

  List<Property> get properties() {
    List<Property> properties = new List<Property>();
    properties.addAll(attributes.list);
    properties.addAll(parents.list);
    return properties;
  }

  bool get identifier() {
    for (Property property in properties) {
      if (property.identifier) {
        return true;
      }
    }
    return false;
  }

  Id get id() {
    return new Id(this);
  }

  bool isAttributeSensitive(String attributeCode) {
    Attribute a = attributes.findByCode(attributeCode);
    return a!= null && a.sensitive ? true : false;
  }

  bool isParentSensitive(String parentCode) {
    Parent p = parents.findByCode(parentCode);
    return p!= null && p.sensitive ? true : false;
  }

  bool isChildSensitive(String childCode) {
    Child c = children.findByCode(childCode);
    return c!= null && c.sensitive ? true : false;
  }

  bool isPropertySensitive(String propertyCode) {
    return isAttributeSensitive(propertyCode) ||
        isParentSensitive(propertyCode) ||
        isChildSensitive(propertyCode);
  }

  String _dropEnd(String text, String end) {
    String withoutEnd = text;
    int endPosition = text.lastIndexOf(end);
    if (endPosition > 0) {
      // Drop the end.
      withoutEnd = text.substring(0, endPosition);
    }
    return withoutEnd;
  }

  String _convertToPlural(String text) {
    var textInPlural;
    if (text.length > 0) {
      String lastCharacterString = text.substring(text.length - 1,
          text.length);
      if (lastCharacterString == 'x') {
        textInPlural = '${text}es';
      } else if (lastCharacterString == 'z') {
        textInPlural = '${text}zes';
      } else if (lastCharacterString == 'y') {
        String withoutLast = _dropEnd(text, lastCharacterString);
        textInPlural = '${withoutLast}ies';
      } else {
        textInPlural = '${text}s';
      }
    }
    return textInPlural;
  }

  String get codeInPlural() {
    if (_codeInPlural != null) {
      return _codeInPlural;
    } else {
      _codeInPlural = _convertToPlural(code);
      return _codeInPlural;
    }
  }

  set codeInPlural(String pluralConceptName) {
    _codeInPlural = pluralConceptName;
  }

  Concept get entryConcept() {
    if (entry) {
      return this;
    } else {
      for (Parent parent in parents) {
        if (parent.internal) {
          return parent.destinationConcept.entryConcept;
        }
      }
      throw new ParentException('No internal parent for the ${code} concept');
    }
  }

}
