
abstract class Neighbor extends Property {

  bool internal = true;
  bool inheritance = false;
  Neighbor opposite;

  // the source concept is inherited from Property
  Concept destinationConcept;

  Neighbor(Concept sourceConcept, this.destinationConcept, String code) :
    super(sourceConcept, code) {
  }

  bool get external() => !internal;

}
