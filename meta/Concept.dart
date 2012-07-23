
class Concept extends Entity<Concept> {

  bool entry = true;
  bool abstract = false;
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

  Attribute getAttribute(String code) => attributes.getEntityByCode(code);

  Parent getParent(String code) => parents.getEntityByCode(code);
  Child getChild(String code) => children.getEntityByCode(code);

  Parent getSourceParent(String code) => sourceParents.getEntityByCode(code);
  Child getSourceChild(String code) => sourceChildren.getEntityByCode(code);
}
