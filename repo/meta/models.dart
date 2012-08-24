
class Models extends Entities<Model> {

}

class Model extends ConceptEntity<Model> {

  String author;
  String description;

  Domain domain;

  Concepts concepts;

  Model(this.domain, String modelCode) {
    super.code = modelCode;
    domain.models.add(this);
    concepts = new Concepts();
  }

  List<Concept> get entryConcepts() => concepts.list.filter((c) => c.entry);

  int get entryConceptCount() => entryConcepts.length;

  Concept getEntryConcept(String entryConceptCode) {
    Concept concept = concepts.findByCode(entryConceptCode);
    if (!concept.entry) {
      throw new Exception('$entryConceptCode concept is not entry.');
    }
    return concept;
  }

  int get conceptCount() => concepts.length;

  Concept getConcept(String conceptCode) => concepts.findByCode(conceptCode);

}

