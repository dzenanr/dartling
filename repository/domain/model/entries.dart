
abstract class ModelEntriesApi {

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

  Entities getEntry(String entryConceptCode) =>
      _entryEntitiesMap[entryConceptCode];

  String toJson() {
    Map<String, Object> modelMap = new Map<String, Object>();
    modelMap['domain'] = _model.domain.code;
    modelMap['model'] = _model.code;
    modelMap['entries'] = entriesToJson();
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

  entriesFromJson(List<Map<String, Object>> entriesList) {
    for (Map<String, Object> entriesMap in entriesList) {
      String conceptCode = entriesMap['concept'];
      var concept = model.concepts.findByCode(conceptCode);
      if (concept == null) {
        throw new ConceptException('${concept.code} concept does not exist.');
      }
      Entities entryEntities = getEntry(conceptCode);
      List<Map<String, Object>> entitiesList = entriesMap['entities'];
      entryEntities = entitiesFromJson(entitiesList, concept);
    }
  }

  Entities entitiesFromJson(List<Map<String, Object>> entitiesList,
                            Concept concept) {
    Entities entities = newEntities(concept.code);
    for (Map<String, Object> entityMap in entitiesList) {
      Entity entity = entityFromJson(entityMap, concept);
      entities.add(entity);
    }
    return entities;
  }

  Entity entityFromJson(Map<String, Object> entityMap, Concept concept) {
    Entity entity = newEntity(concept.code);
    int timeStamp;
    try {
      timeStamp = Math.parseInt(entityMap['oid']);
    } catch (final FormatException e) {
      throw new TypeException('${entityMap['oid']} oid is not int: $e');
    }
    entity.oid = new Oid.ts(timeStamp);
    entity.code = entityMap['code'];
    for (Attribute attribute in concept.attributes) {
      entity.setStringToAttribute(attribute.code, entityMap[attribute.code]);
    }
    for (Child child in concept.children) {
      List<Map<String, Object>> entitiesList = entityMap[child.code];
      var entities = entitiesFromJson(entitiesList, concept);
      entity.setChild(child.code, entities);
    }
    for (Parent parent in concept.parents) {
      String parentOid = entityMap[parent.code];
      if (parentOid == 'null') {
        if (parent.minc == '0') {
          entity.setParent(parent.code, null);
        } else {
          throw new ParentException(
              '${parent.code} parent cannot be null.');
        }
      } else {
        try {
          int parentTimeStamp = Math.parseInt(parentOid);
          Oid oid = new Oid.ts(parentTimeStamp);
          Concept parentConcept = parent.destinationConcept;
          Entity parentEntity = findParentEntity(parentConcept, oid);
          if (parentEntity == null) {
            throw new ParentException(
              '${parentConcept.code} parent entity is not found for the ${oid} oid.');
          }
          entity.setParent(parent.code, parentEntity);
        } catch (final FormatException e) {
          throw new TypeException(
              '${parent.code} parent oid value is not int: $e');
        }
      }
    }
    return entity;
  }

  Entity findParentEntity(Concept parentConcept, Oid oid) {
    if (parentConcept.entry) {
      var entities = getEntry(parentConcept.code);
      return entities.find(oid);
    } else {
      _model.entryConcepts.forEach((entryConcept) {
        var entryEntities = getEntry(entryConcept.code);
        var parentEntity = findEntityFromEntities(entryEntities, oid);
        if (parentEntity != null) {
          return parentEntity;
        }
      });
    }
    // return null;
  }

  Entity findEntityFromEntities(Entities entities, oid) {
    Entity foundEntity = entities.find(oid);
    if (foundEntity != null) {
      return foundEntity;
    }
    for (Entity entity in entities) {
      foundEntity = findEntityFromEntity(entity, oid);
      if (foundEntity != null) {
        return foundEntity;
      }
    }
    // return null;
  }

  Entity findEntityFromEntity(Entity entity, oid) {
    for (Child child in entity.concept.children) {
      Entities childEntities = entity.getChild(child.code);
      var foundEntity = findEntityFromEntities(childEntities, oid);
      if (foundEntity != null) {
        return foundEntity;
      }
    }
    // return null;
  }

}


