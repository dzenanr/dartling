
class Concepts extends Entities<Concept> {

}

class Concept extends Entity<Concept> {

  bool entry = true;
  bool abstract = false;

  String min = '0';
  String max = 'N';

  bool add = true;
  bool remove = true;

  String _plural;
  String description;

  Model model;

  Attributes attributes;
  Parents parents; // destination parent neighbors
  Children children; // destination child neighbors

  Parents sourceParents;
  Children sourceChildren;

  Concept(this.model, String code) {
    super.code = code;
    model.concepts.add(this);

    attributes = new Attributes();

    parents = new Parents();
    children = new Children();

    sourceParents = new Parents();
    sourceChildren = new Children();
  }

  Attribute getAttribute(String code) => attributes.findByCode(code);

  Parent getDestinationParent(String code) => parents.findByCode(code);
  Child getDestinationChild(String code) => children.findByCode(code);

  Parent getSourceParent(String code) => sourceParents.findByCode(code);
  Child getSourceChild(String code) => sourceChildren.findByCode(code);

  bool isAttributeSensitive(String code) {
    Attribute a = attributes.findByCode(code);
    return a!= null && a.sensitive ? true : false;
  }

  bool isParentSensitive(String code) {
    Parent p = parents.findByCode(code);
    return p!= null && p.sensitive ? true : false;
  }

  bool isChildSensitive(String code) {
    Child c = children.findByCode(code);
    return c!= null && c.sensitive ? true : false;
  }

  bool isPropertySensitive(String code) {
    return isAttributeSensitive(code) ||
        isParentSensitive(code) ||
        isChildSensitive(code);
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

  String get plural() {
    if (_plural != null) {
      return _plural;
    } else {
      _plural = _convertToPlural(code);
      return _plural;
    }
  }

  set plural(String pluralConceptName) {
    _plural = pluralConceptName;
  }

}
