part of dartling;

abstract class ModelEntriesApi {

  Model get model;
  Concept getConcept(String conceptCode);
  EntitiesApi getEntry(String entryConceptCode);
  EntityApi find(Oid oid);
  EntityApi findInInternalTree(Concept entryConcept, Oid oid);

  bool get isEmpty;  void clear();

  String toJson();
  fromJson(String json);

}

class ModelEntries implements ModelEntriesApi {

  Model _model;

  Map<String, Entities> _entryEntitiesMap;

  List _nullParents;

  ModelEntries(this._model) {
    _entryEntitiesMap = newEntries();
    _nullParents = new List();
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
    var concept = _model.concepts.singleWhereCode(conceptCode);
    if (concept == null) {
      throw new ConceptError('${concept.code} concept does not exist.');
    }
    if (!concept.entry) {
      return new Entities.of(concept);
    }
    return null;
  }

  EntityApi newEntity(String conceptCode) {
    var concept = _model.concepts.singleWhereCode(conceptCode);
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

  ConceptEntity find(Oid oid) {
    ConceptEntity entity;
    for (Concept entryConcept in _model.entryConcepts) {
      var entity = findInInternalTree(entryConcept, oid);
      if (entity != null) return entity;
    }
    return null;
  }

  ConceptEntity findInInternalTree(Concept entryConcept, Oid oid) {
    Entities entryEntities = getEntry(entryConcept.code);
    return entryEntities.singleDownWhereOid(oid);
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

  String toJson() {
    Map<String, Object> modelMap = new Map<String, Object>();
    modelMap['domain'] = _model.domain.code;
    modelMap['model'] = _model.code;
    modelMap['entries'] = _entriesToJson();
    return JSON.encode(modelMap);
  }

  List<Map<String, Object>> _entriesToJson() {
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

  fromJson(String json) {
    Map<String, Object> modelMap = JSON.decode(json);
    var domain = modelMap['domain'];
    var model = modelMap['model'];
    if (_model.domain.code != domain) {
      throw new CodeError(
          'The $domain domain does not exist.');
    }
    if (_model.code != model) {
      throw new CodeError(
          'The $model model does not exist.');
    }
    _modelFromJson(modelMap);
  }

  _modelFromJson(Map<String, Object> modelMap) {
    List<Map<String, Object>> entriesList = modelMap['entries'];
    _entriesFromJson(entriesList);
    _updateNullParents();
  }

  _updateNullParents() {
    for (List nullParent in _nullParents) {
      Oid parentOid = nullParent[0];
      ConceptEntity entity = nullParent[1];
      Parent parent = nullParent[2];
      Concept parentConcept = parent.destinationConcept;
      ConceptEntity parentEntity =
          findInInternalTree(parentConcept.entryConcept, parentOid);
      if (parentEntity == null) {
        var msg =
        '${entity.concept.code}.${parent.code} ${parent.destinationConcept.code}'
         ' parent entity is not found for the ${parentOid} parent oid.';
        throw new ParentError(msg);
        //print(msg);
      }
      if (parent.identifier) {
        var beforUpdate = parent.update;
        parent.update = true;
        entity.setParent(parent.code, parentEntity);
        parent.update = beforUpdate;
      } else {
        entity.setParent(parent.code, parentEntity);
      }
    }
  }

  _entriesFromJson(List<Map<String, Object>> entriesList) {
    for (Map<String, Object> entriesMap in entriesList) {
      String entryConceptCode = entriesMap['concept'];
      var concept = model.concepts.singleWhereCode(entryConceptCode);
      if (concept == null) {
        throw new ConceptError('${entryConceptCode} concept does not exist.');
      }
      Entities entryEntities = getEntry(entryConceptCode);
      if (entryEntities.length > 0) {
        throw new JsonError(
            '$entryConceptCode entry receiving entities are not empty');
      }
      List<Map<String, Object>> entitiesList = entriesMap['entities'];
      entryEntities.addFrom(_entitiesFromJson(entitiesList, concept, true));
    }
  }

  Entities _entitiesFromJson(List<Map<String, Object>> entitiesList,
                            Concept concept, bool internal) {
    Entities entities = newEntities(concept.code);
    for (Map<String, Object> entityMap in entitiesList) {
      ConceptEntity entity = _entityFromJson(entityMap, concept, internal);
      entities.pre = false;
      entities.post = false;
      entities.add(entity);
      entities.pre = true;
      entities.post = true;
      //entities.errors.display('_entitiesFromJson errors:
      //    ${concept.code} ${entity}');
    }
    return entities;
  }

  ConceptEntity _entityFromJson(Map<String, Object> entityMap, Concept concept, bool internal) {
    ConceptEntity entity;
    int timeStamp;
    try {
      timeStamp = int.parse(entityMap['oid']);
    } on FormatException catch (e) {
      throw new TypeError('${entityMap['oid']} oid is not int: $e');
    }

    var oid = new Oid.ts(timeStamp);
    entity = find(oid);
    if (entity == null) {
      entity = newEntity(concept.code);
      var beforeUpdateOid = entity.concept.updateOid;
      entity.concept.updateOid = true;
      entity.oid = oid;
      entity.concept.updateOid = beforeUpdateOid;

      var beforeUpdateCode = entity.concept.updateCode;
      entity.concept.updateCode = true;
      entity.code = entityMap['code'];
      entity.concept.updateCode = beforeUpdateCode;

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
        List<Map<String, Object>> entitiesList = entityMap[child.code];
        if (entitiesList != null) {
          var childConcept = child.destinationConcept;
          var entities = _entitiesFromJson(entitiesList, childConcept, child.internal);
          assert(entities != null);
          entity.setChild(child.code, entities);
        }
      }

      for (Parent parent in concept.parents) {
        String parentOidString = entityMap[parent.code];
        if (parentOidString == 'null') {
          if (parent.minc != '0') {
            throw new ParentError('${parent.code} parent cannot be null.');
          }
        } else {
          try {
            int parentTimeStamp = int.parse(parentOidString);
            Oid parentOid = new Oid.ts(parentTimeStamp);
            List nullParent = new List(3);
            nullParent[0] = parentOid;
            nullParent[1] = entity;
            nullParent[2] = parent;
            _nullParents.add(nullParent);
          } on FormatException catch (e) {
            throw new TypeError(
                '${parent.code} parent oid value is not int: $e');
          }
        }
      }
    }
    return entity;
  }

  ConceptEntity _findParentEntity(Concept parentConcept, Oid oid) {
    if (parentConcept.entry) {
      var entities = getEntry(parentConcept.code);
      return entities.singleWhereOid(oid);
    } else {
      _model.entryConcepts.forEach((entryConcept) {
        var entryEntities = getEntry(entryConcept.code);
        var parentEntity = _findEntityFromEntities(entryEntities, oid);
        if (parentEntity != null) {
          return parentEntity;
        }
      });
    }
    return null;
  }

  ConceptEntity _findEntityFromEntities(Entities entities, oid) {
    ConceptEntity foundEntity = entities.singleWhereOid(oid);
    if (foundEntity != null) {
      return foundEntity;
    }
    for (ConceptEntity entity in entities) {
      foundEntity = _findEntityFromEntity(entity, oid);
      if (foundEntity != null) {
        return foundEntity;
      }
    }
    return null;
  }

  ConceptEntity _findEntityFromEntity(ConceptEntity entity, oid) {
    for (Child child in entity.concept.children) {
      Entities childEntities = entity.getChild(child.code);
      var foundEntity = _findEntityFromEntities(childEntities, oid);
      if (foundEntity != null) {
        return foundEntity;
      }
    }
    return null;
  }

  display() {
    for (Concept entryConcept in _model.entryConcepts) {
      Entities entryEntities = getEntry(entryConcept.code);
      entryEntities.display(title:entryConcept.code);
    }
  }

  displayJson() {
    print('==============================================================');
    print('${_model.domain.code} ${_model.code} Data in JSON');
    print('==============================================================');
    print(toJson());
    print('--------------------------------------------------------------');
    print('');
  }

}


