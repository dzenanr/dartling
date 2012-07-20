
class Neighbor extends Property {

  bool internal = true;
  bool inheritance = false;
  bool _child = true;
  bool absorb = false;
  Neighbor opposite;

  // the source concept is inherited from Property
  Concept destinationConcept;

  Neighbor(Concept sourceConcept, this.destinationConcept, String code) :
    super(sourceConcept, code) {
    sourceConcept.destinations.add(this);
    destinationConcept.sources.add(this);
  }

  bool get child() => _child;
  bool get parent() => !child;

  set child(bool c) => maxMany ? _child = true : _child = c;

}
