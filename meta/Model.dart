
class Model extends Entity<Model> {

  String author;
  String description;

  Domain domain;

  Concepts concepts;

  Model(this.domain, [String code = 'default']) {
    super.code = code;
    domain.models.add(this);
    concepts = new Concepts();
  }

  List<Concept> get entryConcepts() => concepts.filter((c) => c.entry);

  Concept getEntryConcept(String name) {
    Concept c = concepts.getEntity(name);
    if (!c.entry) {
      throw new Exception('$name concept is not entry.');
    }
    return c;
  }

  Concept getConcept(String name) => concepts.getEntity(name);
}

