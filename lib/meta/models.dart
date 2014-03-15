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
  
  // for model init, order by external parent count (from low to high)
  List<Concept> get orderedEntryConcepts {
    var orderedEntryConceptsCount = 0;
    var orderedEntryConcepts = new List<Concept>();
    for (var c = 0; c < 9; c++) {
      var sameExternalCountConcepts = new List<Concept>();
      for (var concept in entryConcepts) {
        if (concept.parents.externalCount == c) {
          sameExternalCountConcepts.add(concept);
        }
      }
      // order by external child count (from high to low)
      var orderedSameExternalCountConcepts = new List<Concept>();
      for (var s = 8; s >= 0; s--) {
        for (var concept in sameExternalCountConcepts) {
          if (concept.children.externalCount == s) {
            orderedSameExternalCountConcepts.add(concept);
          }
        }
      }
      assert(sameExternalCountConcepts.length == 
          orderedSameExternalCountConcepts.length);
      for (var concept in orderedSameExternalCountConcepts) {
        orderedEntryConcepts.add(concept);
        orderedEntryConceptsCount++;
      }
      if (orderedEntryConceptsCount == entryConcepts.length) {
        return orderedEntryConcepts;
      }
    } 
    var msg = """
      Not all entry concepts are ordered by external parent count (from low to high). 
      There is an entry concept in your model that has more than 9 external neighbors.
      Inform the dartling authors to increase this restriction.
    """;
    throw new ConceptError(msg);
  }

  int get entryConceptCount => entryConcepts.length;
  int get orderedEntryConceptCount => orderedEntryConcepts.length;

  Concept getEntryConcept(String entryConceptCode) {
    Concept concept = concepts.singleWhereCode(entryConceptCode);
    if (!concept.entry) {
      throw new ConceptError('$entryConceptCode concept is not entry.');
    }
    return concept;
  }

  int get conceptCount => concepts.length;

  Concept getConcept(String conceptCode) => concepts.singleWhereCode(conceptCode);

}

