
class Repo {

  Domains _domains;

  Map<String, DomainModels> _domainModelsMap;

  Repo(this._domains) {
    _domainModelsMap = new Map<String, DomainModels>();
  }

  bool add(DomainModels domainModels) {
    var code = domainModels.domain.code;
    var models = getDomainModels(code);
    if (models == null) {
      _domainModelsMap[code] = domainModels;
    } else {
      throw new CodeException('$code domain code exists already in the repository.');
    }
  }

  Domains get domains() => _domains;

  DomainModels get defaultDomainModels() => _domainModelsMap['default'];

  DomainModels getDomainModels(String code) => _domainModelsMap[code];

}
