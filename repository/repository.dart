
class Repo {

  Domains _domains;

  Map<String, DomainData> _domainDataMap;

  Repo(this._domains) {
    _domainDataMap = new Map<String, DomainData>();
  }

  bool add(DomainData domainData) {
    var code = domainData.domain.code;
    var dd = getDomainData(code);
    if (dd == null) {
      _domainDataMap[code] = domainData;
    } else {
      throw new CodeException('$code domain code exists already in the repository.');
    }
  }

  Domains get domains() => _domains;

  DomainData get defaultDomainData() => _domainDataMap['default'];

  DomainData getDomainData(String code) => _domainDataMap[code];

}
