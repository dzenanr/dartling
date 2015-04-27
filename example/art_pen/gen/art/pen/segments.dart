part of art_pen;

// src/data/gen/art/pen/segments.dart

abstract class SegmentGen extends ConceptEntity<Segment> {

  SegmentGen(Concept concept) {
    this.concept = concept;
    Concept lineConcept = concept.model.concepts.singleWhereCode("Line");
    setChild("lines", new Lines(lineConcept));
  }

  bool get visible => getAttribute("visible");
  set visible(bool a) => setAttribute("visible", a);

  String get color => getAttribute("color");
  set color(String a) => setAttribute("color", a);

  int get width => getAttribute("width");
  set width(int a) => setAttribute("width", a);

  Lines get lines => getChild("lines");

  Segment newEntity() => new Segment(concept);

}

abstract class SegmentsGen extends Entities<Segment> {

  SegmentsGen(Concept concept) {
    this.concept = concept;
  }

  Segments newEntities() => new Segments(concept);

}

