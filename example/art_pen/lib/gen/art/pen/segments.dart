part of art_pen;

// src/data/gen/art/pen/segments.dart

abstract class SegmentGen extends ConceptEntity<Segment> {

  SegmentGen(Concept concept) : super.of(concept) {
    Concept lineConcept = concept.model.concepts.findByCode("Line");
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

  SegmentsGen(Concept concept) : super.of(concept);

  Segments newEntities() => new Segments(concept);

}

