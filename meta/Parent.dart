
class Parent extends Neighbor {

  bool absorb = false;

  Parent(Concept sourceConcept, Concept destinationConcept, String code) :
    super(sourceConcept, destinationConcept, code) {
    sourceConcept.destinationParents.add(this);
    destinationConcept.sourceParents.add(this);
  }

}
