
abstract class ModelEntriesApi {

  abstract Map<String, EntitiesApi> newEntries();
  abstract Model get model();
  abstract EntitiesApi getEntry(String entryConceptCode);
  abstract String toJson();

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

  String toJson() {
    Map<String, Object> modelMap = new Map<String, Object>();
    modelMap["domain"] = _model.domain.code;
    modelMap["model"] = _model.code;
    modelMap["entries"] = entriesToJson();
    return JSON.stringify(modelMap);
  }

  List<Map<String, Object>> entriesToJson() {
    List<Map<String, Object>> entriesList = new List<Map<String, Object>>();
    for (Concept entryConcept in _model.entryConcepts) {
      Entities entryEntities = getEntry(entryConcept.code);
      Map<String, Object> entriesMap = new Map<String, Object>();
      entriesMap["concept"] = entryConcept.code;
      entriesMap["entities"] = entryEntities.toJson();
      entriesList.add(entriesMap);
    }
    return entriesList;
  }

}


