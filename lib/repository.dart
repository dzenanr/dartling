part of dartling;

abstract class RepoApi {

  add(DomainModelsApi domainModels);
  Domains get domains;
  DomainModelsApi getDomainModels(String domainCode);
  gen(String library, [bool specific=true]);

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
      throw new CodeError(
          '$domainCode domain code exists already in the repository.');
    }
  }

  Domains get domains => _domains;

  DomainModels getDomainModels(String domainCode) =>
      _domainModelsMap[domainCode];

  gen(String library, [bool specific=true]) {
    title('Generated code, which you must not change, ',
          'in the lib/gen folder of the ${code} repository.');
    for (Domain domain in domains) {
      subTitle('The ${domain.code} domain repository.');
      print(genRepository(domain, library));
      subTitle('The ${domain.code} domain models.');
      print(genModels(domain, library));
      for (Model model in domain.models) {
        subTitle('The ${domain.code}.${model.code} model entries.');
        print(genEntries(model, library));
        for (Concept concept in model.concepts) {
          subTitle('The ${domain.code}.${model.code}.${concept.code} concept.');
          print(genConceptGen(concept, library));
        }
      }
    }
    if (specific) {
      title('Specific code, which you may change, ',
            'in the lib folder of the ${code} repository.');
      for (Domain domain in domains) {
        for (Model model in domain.models) {
          subTitle('The initial ${domain.code}.${model.code} model data.');
          print(genInitDomainModel(model, library));
          for (Concept concept in model.concepts) {
            subTitle('Specific code base, for the '
                     '${domain.code}.${model.code}.${concept.code} concept.');
            print(genConcept(concept, library));
          }
        }
      }

      for (Domain domain in domains) {
        title('Specific library code ',
              'in the lib folder of the ${code} repository.');
        for (Model model in domain.models) {
          subTitle('Code template for the ${domain.code}.${model.code} '
          'model library.');
          print(genDartlingLibrary(model));
          subTitle('Code template for the ${domain.code}.${model.code} '
          'model app library.');
          print(genDartlingLibraryApp(model));
        }
      }

      for (Domain domain in domains) {
        title('Specific gen and test code ',
              'in the test folder of the ${code} repository.');
        for (Model model in domain.models) {
          subTitle('Code template for the code generation of the '
              '${domain.code}.${model.code} model.');
          print(genDartlingGen(model));
          subTitle('Code template for the ${domain.code}.${model.code} '
                   'model tests.');
          print(genDartlingTest(this, model));
        }
      }

      for (Domain domain in domains) {
        title('Specific web code ',
            'in the web folder of the ${code} repository.');
        for (Model model in domain.models) {
          subTitle('Code template for the '
              '${domain.code}.${model.code} model web page.');
          print(genDartlingWeb(model));
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
