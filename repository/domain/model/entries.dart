
abstract class ModelEntriesApi {

  abstract Map<String, EntitiesApi> newEntries();
  abstract Model get model();
  abstract EntitiesApi getEntry(String entryConceptCode);

}

class ModelEntries implements ModelEntriesApi {

  Model _model;

  Map<String, Entities> _entryEntitiesMap;

  ModelEntries(this._model) {
    _entryEntitiesMap = newEntries();
  }

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    _model.entryConcepts.forEach((entryConcept)
      {var entryEntities = new Entities.of(entryConcept);
      entries[entryConcept.code] = entryEntities;
      });
    return entries;
  }

  Model get model() => _model;

  Entities getEntry(String entryConceptCode) =>
      _entryEntitiesMap[entryConceptCode];

}