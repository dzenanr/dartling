part of dartling;

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

  List<Concept> get entryConcepts {
    var selectedElements = concepts.toList().where((c) => c.entry);
    var entryList = new List<Concept>();
    selectedElements.forEach((concept) => entryList.add(concept));
    return entryList;
  }

  int get entryConceptCount => entryConcepts.length;

  Concept getEntryConcept(String entryConceptCode) {
    Concept concept = concepts.singleWhereCode(entryConceptCode);
    if (!concept.entry) {
      throw new Exception('$entryConceptCode concept is not entry.');
    }
    return concept;
  }

  int get conceptCount => concepts.length;

  Concept getConcept(String conceptCode) => concepts.singleWhereCode(conceptCode);

}

