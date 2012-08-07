
class Concepts extends Entities<Concept> {

}

class Concept extends Entity<Concept> {

  bool entry = true;
  bool abstract = false;

  String min = '0';
  String max = 'N';

  bool add = true;
  bool remove = true;

  String pluralName;
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

  Parent getParent(String code) => parents.findByCode(code);
  Child getChild(String code) => children.findByCode(code);

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
}
