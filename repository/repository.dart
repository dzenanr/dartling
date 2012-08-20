
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

  genDomainModels() {
    print(genGeneratedRepository(this));
    for (Domain domain in domains) {
      print(genGeneratedModels(domain));
      for (Model model in domain.models) {
        print(genGeneratedEntries(domain.code.toLowerCase(), model));
        for (Concept concept in model.concepts) {
          print(genGeneratedConcept(domain.code.toLowerCase(),
                                    model.code.toLowerCase(),
                                    concept));
          print(genSpecificConcept(domain.code.toLowerCase(),
                                   model.code.toLowerCase(),
                                   concept));
        }
      }
    }

  }

  gen() {
    genDomainModels();
  }

}
