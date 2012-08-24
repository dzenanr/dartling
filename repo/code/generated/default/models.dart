
class DefaultModels extends DomainModels {

  DefaultModels(Domain domain) : super(domain) {
    add(fromJsonToProjectEntries());
    add(fromJsonToUserEntries());
  }

  ProjectEntries fromJsonToProjectEntries() {
    return new ProjectEntries(fromMagicBoxes(
      defaultProjectModelInJson,
      domain,
      DartlingRepo.defaultProjectModelCode));
  }

  UserEntries fromJsonToUserEntries() {
    return new UserEntries(fromMagicBoxes(
      defaultUserModelInJson,
      domain,
      DartlingRepo.defaultUserModelCode));
  }

}
