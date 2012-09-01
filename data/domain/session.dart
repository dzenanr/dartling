
abstract class DomainSessionApi {

  abstract DomainModelsApi get domainModels;
  abstract PastApi get past;
}

class DomainSession implements DomainSessionApi {

  DomainModels _domainModels;
  Past _past;

  DomainSession(this._domainModels) {
    _past = new Past();
  }

  DomainModels get domainModels => _domainModels;
  Past get past => _past;

}
