
class Concept extends Entity<Concept> {

  bool entry = true;
  bool abstract = false;
  String pluralName;
  String description;

  Model model;

  Attributes attributes;
  Neighbors destinations; // neighbors
  Neighbors sources;

  Concept(this.model, String code) {
    super.code = code;
    model.concepts.add(this);
    attributes = new Attributes();
    destinations = new Neighbors();
    sources = new Neighbors();
  }

  Attribute getAttribute(String code) => attributes.getEntity(code);

  Neighbor getDestination(String code) => destinations.getEntity(code);

  Neighbor getSource(String code) => sources.getEntity(code);
}
