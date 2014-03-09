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
  
  // ordered by external parent count (from 0 to ...)
  List<Concept> get orderedEntryConcepts {
    List<Concept> entryConcepts = this.entryConcepts;
    var orderedEntryConceptsCount = 0;
    List<Concept> orderedEntryConcepts = new List<Concept>();
    for (var c = 0; c < 10; c++) {
      for (Concept entryConcept in entryConcepts) {
        var count = entryConcept.parents.externalCount;
        if (count == c) {
          orderedEntryConcepts.add(entryConcept);
          if (++orderedEntryConceptsCount == entryConcepts.length) {
            return orderedEntryConcepts;
          }
        }
      }
    }
    return orderedEntryConcepts;
  }

  int get entryConceptCount => entryConcepts.length;
  int get orderedEntryConceptCount => orderedEntryConcepts.length;

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

