
class UserData extends ModelData {

  UserData(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Member');
    entries[concept.code] = new Members(concept);
    return entries;
  }

  Members get members() => getEntry('Member');

  Concept get memberConcept() => members.concept;

}