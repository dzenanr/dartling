
class DomainSession {

  Entry _entry;
  Past _past;

  DomainSession(this._entry) {
    _past = new Past();
  }

  Entry get entry() => _entry;
  Past get past() => _past;

}
