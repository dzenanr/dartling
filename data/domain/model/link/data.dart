
class LinkData extends ModelData {

  LinkData(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Category');
    entries[concept.code] = new Categories(concept);
    return entries;
  }

  Categories get categories() => getEntry('Category');

  Concept get categoryConcept() => categories.concept;
  Concept get webLinkConcept() => model.concepts.findByCode('WebLink');

}


