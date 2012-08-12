
class Repo {

  Domains _domains;

  Map<String, DomainModels> _domainModelsMap;

  Repo(this._domains) {
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

}
