part of dartling;

class Children extends Entities<Property> {

}

class Child extends Neighbor {

  Child(Concept sourceConcept, Concept destinationConcept, String childCode) :
    super(sourceConcept, destinationConcept, childCode) {
    sourceConcept.children.add(this);
    destinationConcept.sourceChildren.add(this);
    minc = '0';
    maxc = 'N';
  }

}
