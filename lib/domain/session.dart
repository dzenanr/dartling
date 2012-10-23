part of dartling;

abstract class DomainSessionApi {

  DomainModelsApi get domainModels;
  PastApi get past;
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
