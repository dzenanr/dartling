
class DomainSession {

  DomainData _domainData;
  Past _past;

  DomainSession(this._domainData) {
    _past = new Past();
  }

  DomainData get domainData() => _domainData;
  Past get past() => _past;

}
