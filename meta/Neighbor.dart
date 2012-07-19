
class Neighbor extends Property {

  bool internal = true;
  bool inheritance = false;
  bool _child = true;
  Neighbor opposite;

  // the source concept is the inherited parent concept
  Concept destinationConcept;

  Neighbor(Concept sourceConcept, this.destinationConcept, String code) :
    super(sourceConcept, code) {
    sourceConcept.destinations.add(this);
    destinationConcept.sources.add(this);
  }

  bool get child() => _child;

  set child(bool c) => maxMany ? _child = true : _child = c;

}
