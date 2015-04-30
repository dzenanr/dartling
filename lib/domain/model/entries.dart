part of dartling;

abstract class ModelEntriesApi {

  Model get model;
  Concept getConcept(String conceptCode);
  EntitiesApi getEntry(String entryConceptCode);
  EntityApi single(Oid oid);
  EntityApi internalSingle(String entryConceptCode, Oid oid);
  EntitiesApi internalChild(String entryConceptCode, Oid oid);
  
  bool get isEmpty;  void clear();

  String fromEntryToJson(String entryConceptCode);
  void fromJsonToEntry(String entryJson);
  void populateEntryReferences(String entryJson);
  
  String toJson();
  void fromJson(String json);

}

class ModelEntries implements ModelEntriesApi {

  Model _model;

  Map<String, Entities> _entryEntitiesMap;

  ModelEntries(this._model) {
    _entryEntitiesMap = newEntries();
  }

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    _model.entryConcepts.forEach((entryConcept) {
      var entryEntities = new Entities();
      entryEntities.concept = entryConcept;
      entries[entryConcept.code] = entryEntities;
    });
    return entries;
  }

  Entities newEntities(String conceptCode) {
    var concept = getConcept(conceptCode);
    if (concept == null) {
      throw new ConceptError('${concept.code} concept does not exist.');
    }
    if (!concept.entry) {
      var entities = new Entities();
      entities.concept = concept;
      return entities;
    }
    return null;
  }

  ConceptEntity newEntity(String conceptCode) {
    var concept = getConcept(conceptCode);
    if (concept == null) {
      throw new ConceptError('${concept.code} concept does not exist.');
    }
    var conceptEntity = new ConceptEntity();
    conceptEntity.concept = concept;
    return conceptEntity;
  }

  Model get model => _model;

  Concept getConcept(String conceptCode) {
    return _model.getConcept(conceptCode);
  }

  Entities getEntry(String entryConceptCode) =>
      _entryEntitiesMap[entryConceptCode];

  ConceptEntity single(Oid oid) {
    for (Concept entryConcept in _model.entryConcepts) {
      var entity = internalSingle(entryConcept.code, oid);
      if (entity != null) return entity;
    }
    return null;
  }

  ConceptEntity internalSingle(String entryConceptCode, Oid oid) {
    Entities entryEntities = getEntry(entryConceptCode);
    return entryEntities.internalSingle(oid);
  }

  Entities internalChild(String entryConceptCode, Oid oid) {
    Entities entryEntities = getEntry(entryConceptCode);
    return entryEntities.internalChild(oid);
  }

  bool get isEmpty {
    for (Concept entryConcept in _model.entryConcepts) {
      Entities entryEntities = getEntry(entryConcept.code);
      if (!entryEntities.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void clear() {
    _model.entryConcepts.forEach((entryConcept) {
      var entryEntities = getEntry(entryConcept.code);
      entryEntities.clear();
    });
  }
  
  String fromEntryToJson(String entryConceptCode) => 
      JSON.encode(fromEntryToMap(entryConceptCode));
  
  Map<String, Object> fromEntryToMap(String entryConceptCode) {
    Map<String, Object> entryMap = new Map<String, Object>();
    entryMap['domain'] = _model.domain.code;
    entryMap['model'] = _model.code;  
    entryMap['entry'] = entryConceptCode;   
    Entities entryEntities = getEntry(entryConceptCode);  
    entryMap['entities'] = entryEntities.toJsonList();
    return entryMap;
  }
  
  void fromJsonToEntry(String entryJson) {
    Map<String, Object> entryMap = JSON.decode(entryJson);
    fromMapToEntry(entryMap);
  }
  
  void fromMapToEntry(Map<String, Object> entryMap) {
    var domainCode = entryMap['domain'];
    var modelCode = entryMap['model'];
    var entryConceptCode = entryMap['entry'];
    if (_model.domain.code != domainCode) {
      throw new CodeError(
          'The $domainCode domain does not exist.');
    }
    if (_model.code != modelCode) {
      throw new CodeError(
          'The $modelCode model does not exist.');
    }
    var entryConcept = getConcept(entryConceptCode);
    if (entryConcept == null) {
      throw new ConceptError('${entryConceptCode} concept does not exist.');
    }
    Entities entryEntities = getEntry(entryConceptCode);
    if (entryEntities.length > 0) {
      throw new JsonError(
          '$entryConceptCode entry receiving entities are not empty');
    }
    List<Map<String, Object>> entitiesList = entryMap['entities'];
    entryEntities.fromJsonList(entitiesList);
  }
  
  void populateEntityReferences(Entities entities) {
    for (var entity in entities) {
      for (Parent parent in entity.concept.externalParents) {
        Reference reference = entity.getReference(parent.code);
        if (reference != null) {
          //String parentOidString = reference.parentOidString;
          //String parentConceptCode = reference.parentConceptCode;
          //String entryConceptCode = reference.entryConceptCode;
          var parentEntity = 
              internalSingle(reference.entryConceptCode, reference.oid);
          if (parentEntity == null) {
            throw new ParentError('Parent not found for the reference: '
                                  '${reference.toString()}');
          }
          if (entity.getParent(parent.code) == null) {
            entity.setParent(parent.code, parentEntity);
            //print('parent.opposite.code: ${parent.opposite.code}');
            var parentChildEntities = parentEntity.getChild(parent.opposite.code);
            //print('parentChildEntities.length before add: ${parentChildEntities.length}');
            parentChildEntities.add(entity);
            //print('parentChildEntities.length after add: ${parentChildEntities.length}');
          }
        }
      } 
      for (Child internalChild in entity.concept.internalChildren) {
        var childEntities = entity.getChild(internalChild.code);
        populateEntityReferences(childEntities);
      }
    } 
  }
  
  void populateEntryReferencesFromJsonMap(Map<String, Object> entryMap) {
    //var domainCode = entryMap['domain'];
    //var modelCode = entryMap['model'];
    var entryConceptCode = entryMap['entry'];
    var entryEntities = getEntry(entryConceptCode);
    populateEntityReferences(entryEntities);
  }
  
  void populateEntryReferences(String entryJson) {
    Map<String, Object> entryMap = JSON.decode(entryJson);
    populateEntryReferencesFromJsonMap(entryMap);
  }
  
  String toJson() => JSON.encode(toJsonMap());
  
  Map<String, Object> toJsonMap() { 
    var entriesMap = new Map<String, Object>(); 
    _model.entryConcepts.forEach((entryConcept) {
      entriesMap[entryConcept.code] = fromEntryToMap(entryConcept.code); 
    });
    return entriesMap; 
  }
  
  void fromJson(String entriesJson) {
    Map<String, Object> entriesMap = JSON.decode(entriesJson);
    fromJsonMap(entriesMap);
  }
  
  void fromJsonMap(Map<String, Object> entriesMap) { 
    _model.entryConcepts.forEach((entryConcept) {
      Map<String, Object> entryMap = entriesMap[entryConcept.code];
      fromMapToEntry(entryMap);
    }); 
    populateReferences(entriesMap);
  }  
  
  void populateReferences(Map<String, Object> entriesMap) {
    _model.entryConcepts.forEach((entryConcept) {
      Map<String, Object> entryMap = entriesMap[entryConcept.code];
      populateEntryReferencesFromJsonMap(entryMap);
    });
  }

  void display() {
    for (Concept entryConcept in _model.entryConcepts) {
      Entities entryEntities = getEntry(entryConcept.code);
      entryEntities.display(title:entryConcept.code);
    }
  }

  void displayEntryJson(String entryConceptCode) {
    print('==============================================================');
    print('${_model.domain.code} ${_model.code} ${entryConceptCode} Data in JSON');
    print('==============================================================');
    print(fromEntryToJson(entryConceptCode));
    print('--------------------------------------------------------------');
    print('');
  }
  
  void displayJson() {
    print('==============================================================');
    print('${_model.domain.code} ${_model.code} Data in JSON');
    print('==============================================================');
    print(toJson());
    print('--------------------------------------------------------------');
    print('');
  }
}


