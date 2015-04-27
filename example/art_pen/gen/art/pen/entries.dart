part of art_pen;

// src/data/gen/art/pen/entries.dart

class PenEntries extends ModelEntries {

  PenEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept;
    concept = model.concepts.singleWhereCode("Segment");
    entries["Segment"] = new Segments(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.singleWhereCode(conceptCode);
    if (concept == null) {
      throw new ConceptError("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Segment") {
      return new Segments(concept);
    }
    if (concept.code == "Line") {
      return new Lines(concept);
    }
    return null;
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = model.concepts.singleWhereCode(conceptCode);
    if (concept == null) {
      throw new ConceptError("${conceptCode} concept does not exist.") ;
    }
    if (concept.code == "Segment") {
      return new Segment(concept);
    }
    if (concept.code == "Line") {
      return new Line(concept);
    }
    return null;
  }

  fromJsonToData() {
    fromJson(artPenDataJson);
  }

  Segments get segments => getEntry("Segment");

}

