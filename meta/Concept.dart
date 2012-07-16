
class Concept extends Entity<Concept> {
  
  bool entry = true;
  bool abstract = false;
  String pluralName;
  String description;
  
  Model parentModel;
  
  Attributes childAttributes;
  Neighbors childDestinations; 
  Neighbors childSources;
  
  Concept(this.parentModel, String code) {
    super.code = code;
    parentModel.childConcepts.add(this);
    childAttributes = new Attributes();
    childDestinations = new Neighbors();
    childSources = new Neighbors();
  }
  
}
 