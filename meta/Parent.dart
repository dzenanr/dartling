
class Parent extends Neighbor {

  bool absorb = false;

  Parent(Concept sourceConcept, Concept destinationConcept, String code) :
    super(sourceConcept, destinationConcept, code) {
    sourceConcept.parents.add(this);
    destinationConcept.sourceParents.add(this);
    min = '1';
  }

}
