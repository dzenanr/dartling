part of dartling;

class Parents extends Entities<Property> {
  
  int get externalCount {
    int externalCount = 0;
    for (var parent in this) {
      if (parent.external) externalCount++;
    }
    return externalCount; 
  }
  
}

class Parent extends Neighbor {

  bool absorb = true;

  Parent(Concept sourceConcept, Concept destinationConcept, String parentCode) :
    super(sourceConcept, destinationConcept, parentCode) {
    sourceConcept.parents.add(this);
    destinationConcept.sourceParents.add(this);
    minc = '1';
    maxc = '1';
  }

}
