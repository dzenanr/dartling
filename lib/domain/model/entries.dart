part of dartling;

abstract class ModelEntriesApi {

  Model get model;
  Concept getConcept(String conceptCode);
  EntitiesApi getEntry(String entryConceptCode);
  EntityApi single(Oid oid);
  EntityApi internalSingle(String entryConceptCode, Oid oid);
  EntitiesApi internalChild(String entryConceptCode, Oid oid);
  
  bool get isEmpty;  void clear();

  String toJson(String entryConceptCode);
  fromJson(String json);

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
      var entryEntities = new Entities.of(entryConcept);
      entries[entryConcept.code] = entryEntities;
    });
    return entries;
  }

  EntitiesApi newEntities(String conceptCode) {
    var concept = getConcept(conceptCode);
    if (concept == null) {
      throw new ConceptError('${concept.code} concept does not exist.');
    }
    if (!concept.entry) {
      return new Entities.of(concept);
    }
    return null;
  }

  EntityApi newEntity(String conceptCode) {
    var concept = getConcept(conceptCode);
    if (concept == null) {
      throw new ConceptError('${concept.code} concept does not exist.');
    }
    return new ConceptEntity.of(concept);
  }

  Model get model => _model;

  Concept getConcept(String conceptCode) {
    return _model.getConcept(conceptCode);
  }

  Entities getEntry(String entryConceptCode) =>
      _entryEntitiesMap[entryConceptCode];

  ConceptEntity single(Oid oid) {
    ConceptEntity entity;
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
  
  String toJson(String entryConceptCode) {
    Map<String, Object> entryMap = new Map<String, Object>();
    entryMap['domain'] = _model.domain.code;
    entryMap['model'] = _model.code;  
    entryMap['entry'] = entryConceptCode;   
    Entities entryEntities = getEntry(entryConceptCode);  
    entryMap['entities'] = entryEntities.toJson();
    return JSON.encode(entryMap);
  }
  
  fromJson(String json) {
    Map<String, Object> entryMap = JSON.decode(json);
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
    entryEntities.addFrom(_entitiesFromJson(entitiesList, null, entryConcept));
  }
  
  Entities _entitiesFromJson(List<Map<String, Object>> entitiesList,
                             ConceptEntity internalParent,
                             Concept concept) {
    Entities entities = newEntities(concept.code);
    for (Map<String, Object> entityMap in entitiesList) {
      ConceptEntity entity = 
          _entityFromJson(entityMap, internalParent, concept);
      entities.pre = false;
      entities.post = false;
      entities.add(entity);
      entities.pre = true;
      entities.post = true;
    }
    return entities;  
  }
  
  ConceptEntity _entityFromJson(Map<String, Object> entityMap,
                                ConceptEntity internalParent,
                                Concept concept) {
    ConceptEntity entity;
    int timeStamp;
    try {
      timeStamp = int.parse(entityMap['oid']);
    } on FormatException catch (e) {
      throw new TypeError('${entityMap['oid']} oid is not int: $e');
    }

    var oid = new Oid.ts(timeStamp);
    entity = newEntity(concept.code);
    var beforeUpdateOid = concept.updateOid;
    concept.updateOid = true;
    entity.oid = oid;
    concept.updateOid = beforeUpdateOid;

    var beforeUpdateCode = concept.updateCode;
    concept.updateCode = true;
    entity.code = entityMap['code'];
    concept.updateCode = beforeUpdateCode;

    for (Attribute attribute in concept.attributes) {
      if (attribute.identifier) {
        var beforUpdate = attribute.update;
        attribute.update = true;
        entity.setStringToAttribute(attribute.code, entityMap[attribute.code]);
        attribute.update = beforUpdate;
      } else {
        entity.setStringToAttribute(attribute.code, entityMap[attribute.code]);
      }
    }

    for (Child child in concept.children) {
      if (child.internal) {
        List<Map<String, Object>> entitiesList = entityMap[child.code];
        if (entitiesList != null) {
          var childConcept = child.destinationConcept;
          var entities = _entitiesFromJson(entitiesList, entity, childConcept);
          assert(entities != null);
          entity.setChild(child.code, entities);
        }
      }
    }

    for (Parent parent in concept.parents) {
      Map<String, String> reference = entityMap[parent.code];
      if (reference == 'null') {
        if (parent.minc != '0') {
          throw new ParentError('${parent.code} parent cannot be null.');
        }
      } else {
        String parentOidString = reference['oid'];
        String entityConceptCode = reference['concept'];
        String entryConceptCode = reference['entry'];
        var parentTimeStamp;
        try {
          parentTimeStamp = int.parse(parentOidString);   
        } on FormatException catch (e) {
          throw new TypeError('${parent.code} parent oid is not int: $e');
        }
        if (entityConceptCode != concept.code) {
          throw new ConceptError(
            '${entityConceptCode} entity concept is wrong, should be ${concept.code}.');
        }
        var parentOid = new Oid.ts(parentTimeStamp); 
        if (parent.internal) {        
          if (parentOid == internalParent.oid) {
            entity.setParent(parent.code, internalParent);
          } else {
            throw new ParentError(
                '${parent.code} internal parent oid is wrong.');
          }       
        } else { // parent is external
          ConceptEntity externalParent = 
              internalSingle(entryConceptCode, parentOid);
          if (externalParent == null) {
            throw new ParentError(
              '${parent.code} external parent not found, from json it first.');
          } else {
            entity.setParent(parent.code, externalParent);
            Concept externalParentConcept = externalParent.concept;
            var childNeighbor;
            for (var child in externalParentConcept.children) {
              if (child.opposite == parent) {
                childNeighbor = child;
                break;
              }
            }
            if (childNeighbor != null) {
              var childEntities = externalParent.getChild(childNeighbor.code);
              childEntities.add(entity);
            } else {
              throw new ParentError(
                '${parent.code} external parent child entities not found.');
            }            
          }
        }
      }
    }
    return entity;
  }

  display() {
    for (Concept entryConcept in _model.entryConcepts) {
      Entities entryEntities = getEntry(entryConcept.code);
      entryEntities.display(title:entryConcept.code);
    }
  }

  displayJson(String entryConceptCode) {
    print('==============================================================');
    print('${_model.domain.code} ${_model.code} Data in JSON');
    print('==============================================================');
    print(toJson(entryConceptCode));
    print('--------------------------------------------------------------');
    print('');
  }
}


