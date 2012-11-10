part of art_pen;

// src/data/gen/art/pen/lines.dart

abstract class LineGen extends ConceptEntity<Line> {

  LineGen(Concept concept) : super.of(concept);

  Segment get segment => getParent("segment");
  set segment(Segment p) => setParent("segment", p);

  num get beginX => getAttribute("beginX");
  set beginX(num a) => setAttribute("beginX", a);

  num get beginY => getAttribute("beginY");
  set beginY(num a) => setAttribute("beginY", a);

  num get endX => getAttribute("endX");
  set endX(num a) => setAttribute("endX", a);

  num get endY => getAttribute("endY");
  set endY(num a) => setAttribute("endY", a);

  num get cumulativeAngle => getAttribute("cumulativeAngle");
  set cumulativeAngle(num a) => setAttribute("cumulativeAngle", a);

  num get angle => getAttribute("angle");
  set angle(num a) => setAttribute("angle", a);

  num get pixels => getAttribute("pixels");
  set pixels(num a) => setAttribute("pixels", a);

  Line newEntity() => new Line(concept);

}

abstract class LinesGen extends Entities<Line> {

  LinesGen(Concept concept) : super.of(concept);

  Lines newEntities() => new Lines(concept);

}

