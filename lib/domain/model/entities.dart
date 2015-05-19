part of dartling;

// http://dartlangfr.net/dart-cheat-sheet/
abstract class EntitiesApi<E extends EntityApi<E>> implements Iterable<E> {

  Concept get concept;
  ValidationExceptionsApi get exceptions;
  EntitiesApi<E> get source;

  E firstWhereAttribute(String code, Object attribute);
  E random();
  E singleWhereOid(Oid oid);
  EntityApi internalSingle(Oid oid);
  E singleWhereCode(String code);
  E singleWhereId(IdApi id);
  E singleWhereAttributeId(String code, Object attribute);

  EntitiesApi<E> copy();
  EntitiesApi<E> order([int compare(E a, E b)]); // sort, but not in place
  EntitiesApi<E> selectWhere(bool f(E entity));
  EntitiesApi<E> selectWhereAttribute(String code, Object attribute);
  EntitiesApi<E> selectWhereParent(String code, EntityApi parent);
  EntitiesApi<E> skipFirst(int n);
  EntitiesApi<E> skipFirstWhile(bool f(E entity));
  EntitiesApi<E> takeFirst(int n);
  EntitiesApi<E> takeFirstWhile(bool f(E entity));
  EntitiesApi internalChild(Oid oid);

  void clear();
  void sort([int compare(E a, E b)]); // in place sort

  bool preAdd(E entity);
  bool add(E entity);
  bool postAdd(E entity);
  bool preRemove(E entity);
  bool remove(E entity);
  bool postRemove(E entity);
  
  String toJson();
  void fromJson(String entitiesJson);
  
  void integrate(EntitiesApi<E> fromEntities);
  void integrateAdd(EntitiesApi<E> addEntities);
  void integrateSet(EntitiesApi<E> setEntities);
  void integrateRemove(EntitiesApi<E> removeEntities);
  
}

class Entities<E extends ConceptEntity<E>> implements EntitiesApi<E> {

  Concept _concept;
  var _entityList = new List<E>();
  var _oidEntityMap = new Map<int, E>();
  var _codeEntityMap = new Map<String, E>();
  var _idEntityMap = new Map<String, E>();
  var exceptions = new ValidationExceptions();
  Entities<E> source;

  String minc = '0';
  String maxc = 'N';
  bool pre = false;
  bool post = false;
  bool propagateToSource = false;
  var randomGen = new Random();
  
  Entities<E> newEntities() {
    var entities = new Entities();
    entities.concept = _concept;
    return entities;
  }
  
  ConceptEntity<E> newEntity() {
    var conceptEntity = new ConceptEntity();
    conceptEntity.concept = _concept;
    return conceptEntity;
  }
  
  Concept get concept => _concept;
  void set concept(Concept concept) {
    _concept = concept;
    pre = true;
    post = true;
    propagateToSource = true;
  }  

  E get first => _entityList.first;
  bool get isEmpty => _entityList.isEmpty;
  bool get isNotEmpty => _entityList.isNotEmpty;
  Iterator<E> get iterator => _entityList.iterator;
  E get last => _entityList.last;
  int get length => _entityList.length;
  int get count => length; // for my soul
  E get single => _entityList.single;
  bool any(bool f(E entity)) => _entityList.any(f);

  bool contains(E entity) {
    E element = _oidEntityMap[entity.oid.timeStamp];
    if (entity == element) {
      return true;
    }
    return false;
  }

  E elementAt(int index) => _entityList.elementAt(index); // should we keep it?
  E at(int index) => elementAt(index); // should we keep it?
  bool every(bool f(E entity)) => _entityList.every(f);
  Iterable expand(Iterable f(E entity)) => _entityList.expand(f); // should we keep it?
  E firstWhere(bool f(E entity), {E orElse()}) =>  _entityList.firstWhere(f);
  dynamic fold(initialValue, combine(previousValue, E entity)) =>
      _entityList.fold(initialValue, combine);
  void forEach(bool f(E entity)) =>  _entityList.forEach(f);
  String join([String separator = '']) => _entityList.join(separator);
  E lastWhere(bool f(E entity), {E orElse()}) => _entityList.lastWhere(f);
  Iterable map(f(E entity)) => _entityList.map(f);
  E reduce(E combine(E value, E entity)) => _entityList.reduce(combine); // E? value
  E singleWhere(bool f(E entity)) => _entityList.singleWhere(f);
  Iterable<E> skip(int n) => _entityList.skip(n);
  Iterable<E> skipWhile(bool f(E entity)) => _entityList.skipWhile(f);
  Iterable<E> take(int n) => _entityList.take(n);
  Iterable<E> takeWhile(bool f(E entity)) => _entityList.takeWhile(f);
  List<E> toList({bool growable: true}) => _entityList.toList(growable: true);
  Set<E> toSet() => _entityList.toSet();
  Iterable<E> where(bool f(E entity)) => _entityList.where(f);


  List<E> get internalList => _entityList;
  // set for Polymer only:
  // entities.internalList = toObservable(entities.internalList);
  void set internalList(List<E> observableList) { _entityList = observableList; }


  E firstWhereAttribute(String code, Object attribute) {
    var selectionEntities = selectWhereAttribute(code, attribute);
    if (selectionEntities.length > 0) {
      return selectionEntities.first;
    }  
    return null;
  }

  E random() {
    if (!isEmpty) {
      return _entityList[randomGen.nextInt(length)];
    }
    return null;
  }

  E singleWhereOid(Oid oid) {
    return _oidEntityMap[oid.timeStamp];
  }

  ConceptEntity internalSingle(Oid oid) {
    if (isEmpty) {
      return null;
    }
    ConceptEntity foundEntity = singleWhereOid(oid);
    if (foundEntity != null) {
      return foundEntity;
    }
    if (!_concept.children.isEmpty) {
      for (ConceptEntity entity in _entityList) {
        for (Child child in _concept.children) {
          if (child.internal) {
            Entities childEntities = entity.getChild(child.code);
            ConceptEntity childEntity = childEntities.internalSingle(oid);
            if (childEntity != null) {
              return childEntity;
            } 
          }
        }
      }
    }
    return null;
  }

  Entities internalChild(Oid oid) {
    if (isEmpty) {
      return null;
    }
    ConceptEntity foundEntity = singleWhereOid(oid);
    if (foundEntity != null) {
      return this;
    }
    if (!_concept.children.isEmpty) {
      for (ConceptEntity entity in _entityList) {
        for (Child child in _concept.children) {
          if (child.internal) {
            Entities childEntities = entity.getChild(child.code);
            ConceptEntity childEntity = childEntities.internalSingle(oid);
            if (childEntity != null) {
              return childEntities;
            }             
          }
        }
      }
    }
    return null;
  }

  E singleWhereCode(String code) {
    return _codeEntityMap[code];
  }

  E singleWhereId(Id id) {
    return _idEntityMap[id.toString()];
  }

  E singleWhereAttributeId(String code, Object attribute) {
    return singleWhereId(new Id(_concept)..setAttribute(code, attribute));
  }


  /**
   * Copies the entities.
   * It is not a deep copy.
   */
  Entities<E> copy() {
    if (_concept == null) {
      throw new ConceptException('Entities.copy: concept is not defined.');
    }
    Entities<E> copiedEntities = newEntities();
    copiedEntities.pre = false;
    copiedEntities.post = false;
    copiedEntities.propagateToSource = false;
    for (ConceptEntity entity in this) {
      copiedEntities.add(entity.copy());
    }
    copiedEntities.pre = true;
    copiedEntities.post = true;
    copiedEntities.propagateToSource = true;
    return copiedEntities;
  }

  /**
   * If compare function is not passed, compareTo method will be used.
   * If there is no compareTo method on specific entity,
   * the Entity.compareTo method will be used (code if not null, otherwise id).
   */
  Entities<E> order([int compare(E a, E b)]) {
    if (_concept == null) {
      throw new ConceptException('Entities.order: concept is not defined.');
    }
    Entities<E> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.post = false;
    orderedEntities.propagateToSource = false;
    List<E> sortedList = toList();
    // in place sort
    sortedList.sort(compare);
    sortedList.forEach((entity) => orderedEntities.add(entity));
    orderedEntities.pre = true;
    orderedEntities.post = true;
    orderedEntities.propagateToSource = false;
    orderedEntities.source = this;
    return orderedEntities;
  }

  Entities<E> selectWhere(Function f) {
    if (_concept == null) {
      throw new ConceptException('Entities.selectWhere: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.where(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  Entities<E> selectWhereAttribute(String code, Object attribute) {
    if (_concept == null) {
      throw new ConceptException(
        'Entities.selectWhereAttribute($code, $attribute): concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    for (E entity in _entityList) {
      for (Attribute a in _concept.attributes) {
        if (a.code == code) {
          if (entity.getAttribute(a.code) == attribute) {
            selectedEntities.add(entity);
          }
        }
      }
    }
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  Entities<E> selectWhereParent(String code, EntityApi parent) {
    if (_concept == null) {
      throw new ConceptException(
        'Entities.selectWhereParent($code, $parent): concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    for (E entity in _entityList) {
      for (Parent p in _concept.parents) {
        if (p.code == code) {
          if (entity.getParent(p.code) == parent) {
            selectedEntities.add(entity);
          }
        }
      }
    }
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  Entities<E> skipFirst(int n) {
    if (_concept == null) {
      throw new ConceptException('Entities.skipFirst: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.skip(n);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  Entities<E> skipFirstWhile(bool f(E entity)) {
    if (_concept == null) {
      throw new ConceptException('Entities.skipFirstWhile: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.skipWhile(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  Entities<E> takeFirst(int n) {
    if (_concept == null) {
      throw new ConceptException('Entities.takeFirst: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.take(n);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }

  Entities<E> takeFirstWhile(bool f(E entity)) {
    if (_concept == null) {
      throw new ConceptException('Entities.takeFirstWhile: concept is not defined.');
    }
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.takeWhile(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.source = this;
    return selectedEntities;
  }
  
  String toJson() => JSON.encode(toJsonList());

  List<Map<String, Object>> toJsonList() {
    List<Map<String, Object>> entityList = new List<Map<String, Object>>();
    for (E entity in _entityList) {
      entityList.add(entity.toJsonMap());
    }
    return entityList;
  }
  
  void fromJson(String entitiesJson) {
    List<Map<String, Object>> entitiesList = JSON.decode(entitiesJson);
    fromJsonList(entitiesList);
  }

  /**
   * Loads entities without validations to this, which must be empty.
   */
  void fromJsonList(List<Map<String, Object>> entitiesList, 
               [ConceptEntity internalParent]) {
    if (concept == null) {
      throw new ConceptException('entities concept does not exist.');
    }
    if (length > 0) {
      throw new JsonException('entities are not empty');
    }    
    var beforePre = pre;
    var beforePost = post;
    pre = false;
    post = false;
    for (Map<String, Object> entityMap in entitiesList) {
      var entity = newEntity();
      entity.fromJsonMap(entityMap, internalParent);
      add(entity);
    }
    pre = beforePre;
    post = beforePost;
  }

  /**entity
   * Returns a string that represents this entity by using oid and code.
   */
  String toString() {
    if (_concept != null) {
      return '${_concept.code}: entities:${length}';
    }
    return null;
  }


  void clear() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
    _idEntityMap.clear();
    exceptions.clear();
  }

  /**
   * If compare function is not passed, compareTo method will be used.
   * If there is no compareTo method on specific entity,
   * the Entity.compareTo method will be used (code if not null, otherwise id).
   */
  void sort([int compare(E a, E b)]) {
    // in place sort
    _entityList.sort(compare);
  }


  bool preAdd(E entity) {
    if (!pre) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptException(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptException('Entities.add: concept is not defined.');
    }
    if (!_concept.add) {
      throw new AddException('An entity cannot be added to ${_concept.codes}.');
    }

    bool result = true;

    // max validation
    if (maxc != 'N') {
      int maxInt;
      try {
        maxInt = int.parse(maxc);
        if (length == maxInt) {
          var exception = new ValidationException('max');
          exception.message = '${_concept.codes}.max is $maxc.';
          exception.category = 'max cardinality';

          exceptions.add(exception);
          result = false;
        }
      } on FormatException catch (e) {
        throw new AddException(
          'Entities max is neither N nor a positive integer string: $e');
      }
    }

    // increment and required validation
    for (Attribute a in _concept.attributes) {
      if (a.increment != null) {
        if (length == 0) {
          entity.setAttribute(a.code, a.increment);
        } else if (a.type.code == 'int') {
          var lastEntity = last;
          int incrementAttribute = lastEntity.getAttribute(a.code);
          var attributeUpdate = a.update;
          a.update = true;
          entity.setAttribute(a.code, incrementAttribute + a.increment);
          a.update = attributeUpdate;
        } else {
          throw new TypeException(
              '${a.code} attribute value cannot be incremented.');
        }
      } else if (a.required && entity.getAttribute(a.code) == null) {
        var exception = new ValidationException('required');
        exception.message = '${entity.concept.code}.${a.code} attribute is null.';
        exceptions.add(exception);
        result = false;
      }
    }
    for (Parent p in _concept.parents) {
      if (p.required && entity.getParent(p.code) == null) {
        var exception = new ValidationException('required');
        exception.message = '${entity.concept.code}.${p.code} parent is null.';
        exceptions.add(exception);
        result = false;
      }
    }

    // uniqueness validation
    if (entity.code != null && singleWhereCode(entity.code) != null) {
      var exception = new ValidationException('unique');
      exception.message = '${entity.concept.code}.code is not unique.';
      exceptions.add(exception);
      result = false;
    }
    if (entity.id != null && singleWhereId(entity.id) != null) {
      ValidationException exception = new ValidationException('unique');
      exception.message =
          '${entity.concept.code}.id ${entity.id.toString()} is not unique.';
      exceptions.add(exception);
      result = false;
    }

    return result;
  }

  bool add(E entity) {
    bool added = false;
    if (preAdd(entity)) {
      var propagated = true;
      if (source != null && propagateToSource) {
        propagated = source.add(entity);
      }
      if (propagated) {
        _entityList.add(entity);
        _oidEntityMap[entity.oid.timeStamp] = entity;
        if (entity.code != null) {
          _codeEntityMap[entity.code] = entity;
        }
        if (entity.concept != null && entity.id != null) {
          _idEntityMap[entity.id.toString()] = entity;
        }
        if (postAdd(entity)) {
          added = true;
          entity._whenAdded = new DateTime.now();
        } else {
          var beforePre = pre;
          var beforePost = post;
          pre = false;
          post = false;
          if (!remove(entity)) {
            var msg = '${entity.concept.code} entity (${entity.oid}) '
              'was added, post was not successful, remove was not successful';
            throw new RemoveException(msg);
          } else {
            entity._whenAdded = null;
          }
          pre = beforePre;
          post = beforePost;
        }  
      } else { // not propagated
        var msg = '${entity.concept.code} entity (${entity.oid}) '
          'was not added - propagation to the source ${source.concept.code} '
          'entities was not successful';
        throw new AddException(msg);
      }
    }
    return added;
  }

  bool postAdd(E entity) {
    if (!post) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptException(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptException('Entities.add: concept is not defined.');
    }

    bool result = true;

    //...

    return result;
  }

  bool preRemove(E entity) {
    if (!pre) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptException(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptException('Entities.remove: concept is not defined.');
    }
    if (!_concept.remove) {
      throw new RemoveException(
        'An entity cannot be removed from ${_concept.codes}.');
    }

    bool result = true;

    // min validation
    if (minc != '0') {
      int minInt;
      try {
        minInt = int.parse(minc);
        if (length == minInt) {
          ValidationException exception = new ValidationException('min');
          exception.message = '${_concept.codes}.min is $minc.';
          exceptions.add(exception);
          result = false;
        }
      } on FormatException catch (e) {
        throw new RemoveException(
          'Entities min is not a positive integer string: $e');
      }
    }

    return result;
  }

  bool remove(E entity) {
    bool removed = false;
    if (preRemove(entity)) {
      var propagated = true;
      if (source != null && propagateToSource) {
        propagated = source.remove(entity);
      }
      if (propagated) {
        if (_entityList.remove(entity)) {
          _oidEntityMap.remove(entity.oid.timeStamp);
          if (entity.code != null) {
            _codeEntityMap.remove(entity.code);
          }
          if (entity.concept != null && entity.id != null) {
            _idEntityMap.remove(entity.id.toString());
          }
          if (postRemove(entity)) {
            removed = true;
            entity._whenRemoved = new DateTime.now();
          } else {
            var beforePre = pre;
            var beforePost = post;
            pre = false;
            post = false;
            if (!add(entity)) {
              var msg = '${entity.concept.code} entity (${entity.oid}) '
                'was removed, post was not successful, add was not successful';
              throw new AddException(msg);
            } else {
              entity._whenRemoved = null;
            }
            pre = beforePre;
            post = beforePost;
          }
        }        
      } else { // not propagated
        var msg = '${entity.concept.code} entity (${entity.oid}) '
          'was not removed - propagation to the source ${source.concept.code} '
          'entities was not successful';
        throw new RemoveException(msg);
      }
    }
    return removed;
  }

  bool postRemove(E entity) {
    if (!post) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptException(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptException('Entities.add: concept is not defined.');
    }

    bool result = true;

    //...

    return result;
  }

  /**
   * Updates removes the before entity and adds the after entity, in order to
   * update oid, code and id entity maps.
   *
   * Used only if oid, code or id are set to a new value in the after entity.
   * They can be set only with the help of meta:
   * concept.updateOid, concept.updateCode or property.update.
   */
  bool update(E beforeEntity, E afterEntity) {
    if (beforeEntity.oid == afterEntity.oid &&
        beforeEntity.code == afterEntity.code &&
        beforeEntity.id == afterEntity.id) {
      throw new UpdateException(
          '${_concept.codes}.update can only be used if oid, code or id set.');
    }
    if (remove(beforeEntity)) {
      if (add(afterEntity)) {
        return true;
      } else {
        print('entities.update: ${exceptions.toList()}');
        if (add(beforeEntity)) {
          var exception = new ValidationException('update');
          exception.message =
            '${_concept.codes}.update fails to add after update entity.';
          exceptions.add(exception);
        } else {
          throw new UpdateException(
              '${_concept.codes}.update fails to add back before update entity.');
        }
      }
    } else {
      var exception = new ValidationException('update');
      exception.message =
        '${_concept.codes}.update fails to remove before update entity.';
      exceptions.add(exception);
    }
    return false;
  }

  bool addFrom(Entities<E> entities) {
    bool allAdded = true;
    if (_concept == entities.concept) {
      entities.forEach((entity) => add(entity) ? true : allAdded = false);
    } else {
      throw new ConceptException('The concept of the argument is different.');
    }
    return allAdded;
  }

  bool removeFrom(Entities<E> entities) {
    bool allRemoved = true;
    if (_concept == entities.concept) {
      entities.forEach((entity) => remove(entity) ? true : allRemoved = false);
    } else {
      throw new ConceptException('The concept of the argument is different.');
    }
    return allRemoved;
  }
  
  bool setAttributesFrom(Entities<E> entities) {
    bool allSet = true;
    if (_concept == entities.concept) {
      for (var entity in entities) {
        var baseEntity = singleWhereOid(entity.oid);
        if (baseEntity != null) {
          var baseEntitySet = baseEntity.setAttributesFrom(entity);
          if (!baseEntitySet) {
            allSet = false;
          }
        } else {
          allSet = false;
        }
      }
    } else {
      throw new ConceptException('The concept of the argument is different.');
    }
    return allSet;
  }
  
  void integrate(Entities<E> fromEntities) {
    for (var entity in toList()) {
      var fromEntity = fromEntities.singleWhereOid(entity.oid);
      if (fromEntity == null) {
        remove(entity);
      }
    }
    for (var fromEntity in fromEntities) {
      var entity = singleWhereOid(fromEntity.oid);
      if (entity != null) {
        if (entity.whenSet.millisecondsSinceEpoch <
            fromEntity.whenSet.millisecondsSinceEpoch) {
          entity.setAttributesFrom(fromEntity);
        }
      } else {
        add(fromEntity);
      }
    } 
  }
  
  void integrateAdd(Entities<E> addEntities) {
    for (var addEntity in addEntities) {
      var entity = singleWhereOid(addEntity.oid);
      if (entity == null) {
        add(addEntity);
      } 
    } 
  }
  
  void integrateSet(Entities<E> setEntities) {
    for (var setEntity in setEntities) {
      var entity = singleWhereOid(setEntity.oid);
      if (entity != null) {
        if (entity.whenSet.millisecondsSinceEpoch <
            setEntity.whenSet.millisecondsSinceEpoch) {
          entity.setAttributesFrom(setEntity);
        }
      } 
    } 
  }
  
  void integrateRemove(Entities<E> removeEntities) {
    for (var removeEntity in removeEntities) {
      var entity = singleWhereOid(removeEntity.oid);
      if (entity != null) {
        remove(entity);
      } 
    } 
  }

  /**
  * Displays (prints) a title, then entities.
  */
  void display({String title:'Entities', String prefix:'', bool withOid:true, 
    bool withChildren:true, bool withInternalChildren:true}) {
    var s = prefix;
    if (!_concept.entry || (_concept.entry && _concept.parents.length > 0)) {
      s = '$prefix  ';
    }
    if (title != '') {
      //print('');
      print('${s}======================================');
      print('${s}$title                                ');
      print('${s}======================================');
      //print('');
    }
    for (E e in _entityList) {
      e.display(prefix:s, withOid:withOid, 
        withChildren:withChildren, withInternalChildren:withInternalChildren);
    }
  }

  void displayOidMap() {
    _oidEntityMap.forEach((k,v) {
      print('oid $k: $v');
    });
  }

  void displayCodeMap() {
    _codeEntityMap.forEach((k,v) {
      print('code $k: $v');
    });
  }

  void displayIdMap() {
    _idEntityMap.forEach((k,v) {
      print('id $k: $v');
    });
  }

}
