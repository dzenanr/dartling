
class Concept extends Entity<Concept> {

  bool entry = true;
  bool abstract = false;
  String pluralName;
  String description;

  Model model;

  Attributes attributes;
  Parents destinationParents; // parent neighbors
  Children destinationChildren; // child neighbors

  Parents sourceParents;
  Children sourceChildren;

  Concept(this.model, String code) {
    super.code = code;
    model.concepts.add(this);

    attributes = new Attributes();

    destinationParents = new Parents();
    destinationChildren = new Children();

    sourceParents = new Parents();
    sourceChildren = new Children();
  }

  Attribute getAttribute(String code) => attributes.getEntityByCode(code);

  Parent getDestinationParent(String code) =>
      destinationParents.getEntityByCode(code);
  Child getDestinationChild(String code) =>
      destinationChildren.getEntityByCode(code);

  Parent getSourceParent(String code) => sourceParents.getEntityByCode(code);
  Child getSourceChild(String code) => sourceChildren.getEntityByCode(code);
}
