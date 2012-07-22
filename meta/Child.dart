
class Child extends Neighbor {

  Child(Concept sourceConcept, Concept destinationConcept, String code) :
    super(sourceConcept, destinationConcept, code) {
    sourceConcept.destinationChildren.add(this);
    destinationConcept.sourceChildren.add(this);
  }

}
