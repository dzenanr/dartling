part of art_pen;

// src/data/gen/art/pen/lines.dart

abstract class LineGen extends ConceptEntity<Line> {

  LineGen(Concept concept) {
    this.concept = concept;
  }

  Segment get segment => getParent("segment");
  void set segment(Segment p) { setParent("segment", p); }

  num get beginX => getAttribute("beginX");
  void set beginX(num a) { setAttribute("beginX", a); }

  num get beginY => getAttribute("beginY");
  void set beginY(num a) { setAttribute("beginY", a); }

  num get endX => getAttribute("endX");
  void set endX(num a) { setAttribute("endX", a); }

  num get endY => getAttribute("endY");
  void set endY(num a) { setAttribute("endY", a); }

  num get cumulativeAngle => getAttribute("cumulativeAngle");
  void set cumulativeAngle(num a) { setAttribute("cumulativeAngle", a); }

  num get angle => getAttribute("angle");
  void set angle(num a) { setAttribute("angle", a); }

  num get pixels => getAttribute("pixels");
  void set pixels(num a) { setAttribute("pixels", a); }

  Line newEntity() => new Line(concept);

}

abstract class LinesGen extends Entities<Line> {

  LinesGen(Concept concept) {
    this.concept = concept;
  }

  Lines newEntities() => new Lines(concept);

}

