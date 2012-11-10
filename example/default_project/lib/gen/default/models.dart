part of default_project;

// data/gen/default/models.dart

class DefaultModels extends DomainModels {

  DefaultModels(Domain domain) : super(domain) {
    add(fromJsonToProjectEntries());
  }

  ProjectEntries fromJsonToProjectEntries() {
    return new ProjectEntries(fromMagicBoxes(
      defaultProjectModelJson,
      domain,
      DefaultRepo.defaultProjectModelCode));
  }

}


