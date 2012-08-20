
abstract class RepoApi {

  abstract add(DomainModelsApi domainModels);
  abstract Domains get domains();
  abstract DomainModelsApi getDomainModels(String domainCode);

}

class Repo implements RepoApi {

  String code;

  Domains _domains;

  Map<String, DomainModels> _domainModelsMap;

  Repo(this._domains, [this.code='Dartling']) {
    _domainModelsMap = new Map<String, DomainModels>();
  }

  add(DomainModels domainModels) {
    var domainCode = domainModels.domain.code;
    var models = getDomainModels(domainCode);
    if (models == null) {
      _domainModelsMap[domainCode] = domainModels;
    } else {
      throw new CodeException(
          '$domainCode domain code exists already in the repository.');
    }
  }

  Domains get domains() => _domains;

  DomainModels getDomainModels(String domainCode) =>
      _domainModelsMap[domainCode];

  gen() {
    title('Generated code, which should not be changed, ',
          'for the generated folder in the ${code} repository.');
    print(genGeneratedRepository(this));
    for (Domain domain in domains) {
      subTitle('The ${domain.code} domain models.');
      print(genGeneratedModels(domain));
      for (Model model in domain.models) {
        subTitle('The ${model.code} model entries.');
        print(genGeneratedEntries(domain.code.toLowerCase(), model));
        for (Concept concept in model.concepts) {
          subTitle('Generated code, which should not be changed, '
                   'for the ${concept.code} concept.');
          print(genGeneratedConcept(domain.code.toLowerCase(),
                                    model.code.toLowerCase(),
                                    concept));
        }
      }
    }
    for (Domain domain in domains) {
      title('Code generated for the specific folder in the ${code} repository.');
      for (Model model in domain.models) {
        for (Concept concept in model.concepts) {
          subTitle('Specific code base, where specific code may be added, '
                   'for the ${concept.code} concept.');
          print(genSpecificConcept(domain.code.toLowerCase(),
                                   model.code.toLowerCase(),
                                   concept));
        }
      }
    }
    for (Domain domain in domains) {
      title('Code generated for the test folder in the ${code} repository.');
      for (Model model in domain.models) {
        subTitle('Code template for the ${model.code} model tests.');
        print(genTestData(domain.code.toLowerCase(), model.code.toLowerCase()));
      }
    }
  }

  title(String title, [String title1='']) {
    print('');
    print('==================================================================');
    print('$title                                                            ');
    print('$title1                                                            ');
    print('==================================================================');
    print('');
  }

  subTitle(String subTitle) {
    print('');
    print('-----------------------------------------------------');
    print('$subTitle                                             ');
    print('-----------------------------------------------------');
    print('');
  }

}
