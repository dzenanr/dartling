
class Concept extends Entity<Concept> {

  bool entry = true;
  bool abstract = false;
  String pluralName;
  String description;

  Model model;

  Attributes attributes;
  Neighbors destinations;
  Neighbors sources;

  Concept(this.model, String code) {
    super.code = code;
    model.concepts.add(this);
    attributes = new Attributes();
    destinations = new Neighbors();
    sources = new Neighbors();
  }

}
