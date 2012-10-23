part of dartling;

class Parents extends Entities<Property> {

}

class Parent extends Neighbor {

  bool absorb = false;

  Parent(Concept sourceConcept, Concept destinationConcept, String parentCode) :
    super(sourceConcept, destinationConcept, parentCode) {
    sourceConcept.parents.add(this);
    destinationConcept.sourceParents.add(this);
    minc = '1';
    maxc = '1';
  }

}
