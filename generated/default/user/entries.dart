
class UserEntries extends ModelEntries {

  UserEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('User');
    entries[concept.code] = new Users(concept);
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept.code == 'User') {
      return new Users(concept);
    } else {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
  }

  Entity newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept.code == 'User') {
      return new User(concept);
    } else {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
  }

  fromJsonToData() {
    fromJson(defaultUserDataInJson);
  }

  Users get users() => getEntry('User');

}



