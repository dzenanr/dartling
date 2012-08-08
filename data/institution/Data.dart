
class EcoleEntry extends Entry {

  EcoleEntry(Domain domain) : super(domain);

  Map<String, Data> newData() {
    var data = new Map<String, Data>();
    var model = domain.models.findByCode('default');
    data[model.code] = new EcoleData(model, this);
    return data;
  }

  EcoleData get data() => getData('default');

}

class EcoleData extends Data {

  EcoleEntry entry;

  EcoleData(Model model, this.entry) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Ecole');
    entries[concept.code] = new Ecoles(concept);
    return entries;
  }

  Ecoles get ecoles() => getEntry('Ecole');

  Concept get ecoleConcept() => ecoles.concept;

}