part of art_pen;

// src/data/art/pen/segments.dart

class Segment extends SegmentGen {

  Segment(Concept concept) : super(concept);

  // begin: added by hand
  //bool visible = true;

  String text;

  //set lines(Lines lines) => setChild("lines", lines);
  // end: added by hand

}

class Segments extends SegmentsGen {

  Segments(Concept concept) : super(concept);

}

