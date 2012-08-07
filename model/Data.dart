
class Data {

  Model _model;

  Map<String, Entities> _entryConceptMap;

  Data(this._model) {
    _entryConceptMap = newEntries();
  }

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    _model.entryConcepts.forEach((c)
      {var entryEntities = new Entities.of(c);
      entries[c.code] = entryEntities;
      });
    return entries;
  }

  Model get model() => _model;

  Entities getEntry(String code) => _entryConceptMap[code];

}