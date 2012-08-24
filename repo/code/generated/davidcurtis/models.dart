
class DavidCurtisModels extends DomainModels {

  DavidCurtisModels(Domain domain) : super(domain) {
    add(fromJsonToInstitutionEntries());
  }

  InstitutionEntries fromJsonToInstitutionEntries() {
    return new InstitutionEntries(fromMagicBoxes(
      davidcurtisInstitutionModelInJson,
      domain,
      DartlingRepo.davidcurtisInstitutionModelCode));
  }

}
