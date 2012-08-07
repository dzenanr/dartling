
class LinkEntry extends Entry {

  LinkEntry(Domain domain) : super(domain);

  Map<String, Data> newData() {
    var data = new Map<String, Data>();
    var model = domain.models.getEntityByCode('default');
    data[model.code] = new LinkData(model, this);
    return data;
  }

  LinkData get data() => getData('default');

}

class LinkData extends Data {

  LinkEntry entry;

  LinkData(Model model, this.entry) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.getEntityByCode('Category');
    entries[concept.code] = new Categories(concept);
    return entries;
  }

  Categories get categories() => getEntry('Category');

  Concept get categoryConcept() => categories.concept;
  Concept get webLinkConcept() => model.concepts.getEntityByCode('WebLink');

}



