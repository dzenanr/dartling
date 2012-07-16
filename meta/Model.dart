
class Model extends Entity<Model> {
  
  String author;
  String description;
  
  Domain parentDomain;
  
  Concepts childConcepts;
  
  Model(this.parentDomain, [String code = 'default']) {
    super.code = code;
    parentDomain.childModels.add(this);
    childConcepts = new Concepts();
  }
  
  List<Concept> get entryConcepts() => childConcepts.filter((c) => c.entry);
  
}

