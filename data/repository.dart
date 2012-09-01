
abstract class RepoApi {

  abstract add(DomainModelsApi domainModels);
  abstract Domains get domains;
  abstract DomainModelsApi getDomainModels(String domainCode);
  abstract gen([bool specific=true]);

}

class Repo implements RepoApi {

  String code;

  Domains _domains;

  Map<String, DomainModels> _domainModelsMap;

  Repo([this.code='Dartling']) {
    _domains = new Domains();
    _domainModelsMap = new Map<String, DomainModels>();
  }

  Repo.from(this._domains, [this.code='Dartling']) {
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

  Domains get domains => _domains;

  DomainModels getDomainModels(String domainCode) =>
      _domainModelsMap[domainCode];

  gen([bool specific=true]) {
    title('Generated code, which you must not change, ',
          'for the repo/code/generated folder in the ${code} repository.');
    for (Domain domain in domains) {
      subTitle('The ${domain.code} domain repository.');
      print(genGenRepository(domain));
      subTitle('The ${domain.code} domain models.');
      print(genGenModels(domain));
      for (Model model in domain.models) {
        subTitle('The ${model.code} model entries.');
        print(genGenEntries(model));
        for (Concept concept in model.concepts) {
          subTitle('The ${concept.code} concept.');
          print(genGenConcept(concept));
        }
      }
    }
    if (specific) {
      title('Specific code, which you may change, ',
            'for the repo/code/specific folder in the ${code} repository.');
      for (Domain domain in domains) {
        for (Model model in domain.models) {
          subTitle('The ${domain.code}${model.code} initial data.');
          print(genInitDomainModel(model));
          for (Concept concept in model.concepts) {
            subTitle('Specific code base, for the ${concept.code} concept.');
            print(genConcept(concept));
          }
        }
      }
      subTitle('The dartling.dart file with imports, sources and the main method');
      print(genDartling(this));
      for (Domain domain in domains) {
        title('Specific test code, which you should change, ',
            'for the repo/code/specific/tests folder in the ${code} repository.');
        for (Model model in domain.models) {
          subTitle('Code template for the ${model.code} model tests.');
          print(genTestData(model));
        }
      }
      subTitle('The app.dart file with imports, sources and the main method');
      print(genApp(this));
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
