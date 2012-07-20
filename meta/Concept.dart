
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

  Attribute getAttribute(String name) => attributes.getEntity(name);

  Neighbor getDestination(String name) => destinations.getEntity(name);

  Neighbor getSource(String name) => sources.getEntity(name);
}
