
class Parents extends Entities<Property> {

}

class Parent extends Neighbor {

  bool absorb = false;

  Parent(Concept sourceConcept, Concept destinationConcept, String code) :
    super(sourceConcept, destinationConcept, code) {
    sourceConcept.parents.add(this);
    destinationConcept.sourceParents.add(this);
    minc = '1';
    maxc = '1';
  }

}
