
class Children extends Entities<Property> {

}

class Child extends Neighbor {

  Child(Concept sourceConcept, Concept destinationConcept, String code) :
    super(sourceConcept, destinationConcept, code) {
    sourceConcept.children.add(this);
    destinationConcept.sourceChildren.add(this);
    minc = '0';
    maxc = 'N';
  }

}
