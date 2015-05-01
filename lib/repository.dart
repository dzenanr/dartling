part of dartling;

abstract class RepoApi {

  void add(DomainModelsApi domainModels);
  Domains get domains;
  DomainModelsApi getDomainModels(String domainCode);
  void gen(String library, [bool specific=true]);

}

//class Repo implements RepoApi {
class Repo {
  
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

  void add(DomainModels domainModels) {
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
  
  void gen(String library, [bool specific=true]) {
    title('lib folder');
    subTitle('repository');
    print(genRepository(this, library));
    
    for (Domain domain in domains) {
      subTitle('libraries');
      for (Model model in domain.models) {
        subTitle('${domain.code}.${model.code} model library');
        print(genDartlingLibrary(model));
        subTitle('${domain.code}.${model.code} model app library');
        print(genDartlingLibraryApp(model));
      }
    }
    
    title('You should not change the generated code in the lib/gen folder.');
    for (Domain domain in domains) {
      subTitle('${domain.code} domain models');
      print(genModels(domain, library));
      for (Model model in domain.models) {
        subTitle('${domain.code}.${model.code} model entries');
        print(genEntries(model, library));
        for (Concept concept in model.concepts) {
          subTitle('${domain.code}.${model.code}.${concept.code} concept');
          print(genConceptGen(concept, library));
        }
      }
    }
    
    if (specific) {    
      for (Domain domain in domains) {
        title('You may change the generated code in the '
              'lib/${domain.codeFirstLetterLower} folder.');
        subTitle('${domain.code} domain');
        print(genDomain(domain, library));
        for (Model model in domain.models) {
          subTitle('${domain.code}.${model.code} model');
          print(genModel(model, library));
          for (Concept concept in model.concepts) {
            subTitle('${domain.code}.${model.code}.${concept.code} concept');
            print(genConcept(concept, library));
          }
          for (Concept entryConcept in model.entryConcepts) {
            subTitle('${domain.code}.${model.code}.${entryConcept.code} model tests');
            print(genDartlingTest(this, model, entryConcept));
          }
        }
      }

      for (Domain domain in domains) {
        title('Specific gen and test code in the test folder.');
        for (Model model in domain.models) {
          subTitle('Code generation of the '
                   '${domain.code}.${model.code} model');
          print(genDartlingGen(model));
        }
      }

      for (Domain domain in domains) {
        title('Specific code in the web folder.');
        for (Model model in domain.models) {
          subTitle('${domain.code}.${model.code} model web page');
          print(genDartlingWeb(model));
        }
      }
    }
  }

  void title(String title, [String title1='']) {
    print('');
    print('==================================================================');
    print('$title                                                            ');
    print('$title1                                                            ');
    print('==================================================================');
    print('');
  }

  void subTitle(String subTitle) {
    print('');
    print('-----------------------------------------------------');
    print('$subTitle                                             ');
    print('-----------------------------------------------------');
    print('');
  }

}
