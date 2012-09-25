
abstract class RepoApi {

  abstract add(DomainModelsApi domainModels);
  abstract Domains get domains;
  abstract DomainModelsApi getDomainModels(String domainCode);
  abstract gen([String place='pub', bool specific=true]);

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

  gen([String place='pub', bool specific=true]) {
    title('Generated code, which you must not change, ',
          'for the src/data/gen folder in the ${code} repository.');
    for (Domain domain in domains) {
      subTitle('The ${domain.code} domain repository.');
      print(genGenRepository(domain));
      subTitle('The ${domain.code} domain models.');
      print(genGenModels(domain));
      for (Model model in domain.models) {
        subTitle('The ${domain.code}.${model.code} model entries.');
        print(genGenEntries(model));
        for (Concept concept in model.concepts) {
          subTitle('The ${domain.code}.${model.code}.${concept.code} concept.');
          print(genGenConcept(concept));
        }
      }
    }
    if (specific) {
      title('Specific code, which you may change, ',
            'for the src/data folder in the ${code} repository.');
      for (Domain domain in domains) {
        for (Model model in domain.models) {
          subTitle('The initial ${domain.code}.${model.code} model data.');
          print(genInitDomainModel(model));
          for (Concept concept in model.concepts) {
            subTitle('Specific code base, for the '
                     '${domain.code}.${model.code}.${concept.code} concept.');
            print(genConcept(concept));
          }
        }
      }
      subTitle('The dartling_data.dart file with imports, sources and '
               'the main method');
      print(genDartlingData(place, this));
      subTitle('The dartling_view.dart file with imports, sources and '
               'the main method');
      print(genDartlingView(place, this));

      for (Domain domain in domains) {
        title('Specific test code, which you should change, ',
            'for the test/data folder in the ${code} repository.');
        for (Model model in domain.models) {
          subTitle('Code template for the ${domain.code}.${model.code} '
                   'model tests.');
          print(genTestData(place, this, model));
        }
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
