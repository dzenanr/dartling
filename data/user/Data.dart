
class UserEntry extends Entry {

  UserEntry(Domain domain) : super(domain);

  Map<String, Data> newData() {
    var data = new Map<String, Data>();
    var model = domain.models.findByCode('default');
    data[model.code] = new UserData(model, this);
    return data;
  }

  UserData get data() => getData('default');

}

class UserData extends Data {

  UserEntry entry;

  UserData(Model model, this.entry) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Member');
    entries[concept.code] = new Members(concept);
    return entries;
  }

  Members get members() => getEntry('Member');

  Concept get memberConcept() => members.concept;

}