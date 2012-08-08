
class EcoleEntry extends Entry {

  EcoleEntry(Domain domain) : super(domain);

  Map<String, Data> newData() {
    var data = new Map<String, Data>();
    var model = domain.models.findByCode('default');
    data[model.code] = new IstitutionData(model, this);
    return data;
  }

  UserData get data() => getData('default');

}

class IstitutionData extends Data {

  EcoleEntry entry;

  IstitutionData(Model model, this.entry) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Member');
    entries[concept.code] = new Members(concept);
    return entries;
  }

  Ecoles get ecoles() => getEntry('Ecoles');

  Concept get ecoleConcept() => ecoles.concept;

}