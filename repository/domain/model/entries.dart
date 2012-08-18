
abstract class ModelEntriesApi {

  abstract Model get model();
  abstract Concept getConcept(String conceptCode);
  abstract EntitiesApi getEntry(String entryConceptCode);
  abstract EntityApi find(Oid oid);
  abstract EntityApi findInInternalTree(Concept entryConcept, Oid oid);

  abstract bool get empty();
  abstract clear();

  abstract String toJson();
  abstract fromJson(String json);

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
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
    if (!concept.entry) {
      return new Entities.of(concept);
    }
  }

  EntityApi newEntity(String conceptCode) {
    var concept = model.concepts.findByCode(conceptCode);
    if (concept == null) {
      throw new ConceptException('${concept.code} concept does not exist.');
    }
    return new Entity.of(concept);
  }

  Model get model() => _model;

  Concept getConcept(String conceptCode) {
    return _model.getConcept(conceptCode);
  }

  Entities getEntry(String entryConceptCode) =>
      _entryEntitiesMap[entryConceptCode];

  Entity find(Oid oid) {
    Entity entity;
    for (Concept entryConcept in _model.entryConcepts) {
      return findInInternalTree(entryConcept, oid);
    }
  }

  Entity findInInternalTree(Concept entryConcept, Oid oid) {
    Entities entryEntities = getEntry(entryConcept.code);
    return entryEntities.deepFind(oid);
  }

  bool get empty() {
    for (Concept entryConcept in _model.entryConcepts) {
      Entities entryEntities = getEntry(entryConcept.code);
      if (!entryEntities.empty) {
        return false;
      }
    }
    return true;
  }

  clear() {
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
    return JSON.stringify(modelMap);
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
    Map<String, Object> modelMap = JSON.parse(json);
    var domain = modelMap['domain'];
    var model = modelMap['model'];
    if (_model.domain.code != domain) {
      throw new CodeException(
          'The $domain domain does not exist.');
    }
    if (_model.code != model) {
      throw new CodeException(
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
      Entity entity = nullParent[1];
      Parent parent = nullParent[2];
      Concept parentConcept = parent.destinationConcept;
      Entity parentEntity =
          findInInternalTree(parentConcept.entryConcept, parentOid);
      if (parentEntity == null) {
        var msg =
        '${entity.concept.code}.${parent.code} ${parent.destinationConcept.code}'
         ' parent entity is not found for the ${parentOid} parent oid.';
        throw new ParentException(msg);
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
      var concept = model.concepts.findByCode(entryConceptCode);
      if (concept == null) {
        throw new ConceptException('${concept.code} concept does not exist.');
      }
      Entities entryEntities = getEntry(entryConceptCode);
      if (entryEntities.count > 0) {
        throw new JsonException(
            '$entryConceptCode entry receiving entities are not empty');
      }
      List<Map<String, Object>> entitiesList = entriesMap['entities'];
      entryEntities.addFrom(_entitiesFromJson(entitiesList, concept));
    }
  }

  Entities _entitiesFromJson(List<Map<String, Object>> entitiesList,
                            Concept concept) {
    assert(concept != null);
    assert(concept.code != null);
    Entities entities = newEntities(concept.code);
    for (Map<String, Object> entityMap in entitiesList) {
      Entity entity = _entityFromJson(entityMap, concept);
      assert(entity != null);
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

  Entity _entityFromJson(Map<String, Object> entityMap, Concept concept) {
    Entity entity = newEntity(concept.code);
    int timeStamp;
    try {
      timeStamp = Math.parseInt(entityMap['oid']);
    } catch (final FormatException e) {
      throw new TypeException('${entityMap['oid']} oid is not int: $e');
    }

    var beforeUpdateOid = entity.concept.updateOid;
    entity.concept.updateOid = true;
    entity.oid = new Oid.ts(timeStamp);
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
        var entities = _entitiesFromJson(entitiesList, childConcept);
        assert(entities != null);
        entity.setChild(child.code, entities);
      }
    }

    for (Parent parent in concept.parents) {
      String parentOidString = entityMap[parent.code];
      if (parentOidString == 'null') {
        if (parent.minc != '0') {
          throw new ParentException('${parent.code} parent cannot be null.');
        }
      } else {
        try {
          int parentTimeStamp = Math.parseInt(parentOidString);
          Oid parentOid = new Oid.ts(parentTimeStamp);
          List nullParent = new List(3);
          nullParent[0] = parentOid;
          nullParent[1] = entity;
          nullParent[2] = parent;
          _nullParents.add(nullParent);
        } catch (final FormatException e) {
          throw new TypeException(
              '${parent.code} parent oid value is not int: $e');
        }
      }
    }
    return entity;
  }

  Entity _findParentEntity(Concept parentConcept, Oid oid) {
    if (parentConcept.entry) {
      var entities = getEntry(parentConcept.code);
      return entities.find(oid);
    } else {
      _model.entryConcepts.forEach((entryConcept) {
        var entryEntities = getEntry(entryConcept.code);
        var parentEntity = _findEntityFromEntities(entryEntities, oid);
        if (parentEntity != null) {
          return parentEntity;
        }
      });
    }
    // return null;
  }

  Entity _findEntityFromEntities(Entities entities, oid) {
    Entity foundEntity = entities.find(oid);
    if (foundEntity != null) {
      return foundEntity;
    }
    for (Entity entity in entities) {
      foundEntity = _findEntityFromEntity(entity, oid);
      if (foundEntity != null) {
        return foundEntity;
      }
    }
    // return null;
  }

  Entity _findEntityFromEntity(Entity entity, oid) {
    for (Child child in entity.concept.children) {
      Entities childEntities = entity.getChild(child.code);
      var foundEntity = _findEntityFromEntities(childEntities, oid);
      if (foundEntity != null) {
        return foundEntity;
      }
    }
    // return null;
  }

  display(String json, [String title='Model in JSON']) {
    print('==============================================================');
    print('$title');
    print('==============================================================');
    print(json);
    print('--------------------------------------------------------------');
    print('');
  }

}


