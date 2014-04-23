part of dartling;

// http://dartlangfr.net/dart-cheat-sheet/
abstract class EntitiesApi<E extends EntityApi<E>> implements Iterable<E> {

  Concept get concept;
  ValidationErrorsApi get errors;
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
  fromJson(String entitiesJson);

}

class Entities<E extends ConceptEntity<E>> implements EntitiesApi<E> {

  Concept _concept;
  List<E> _entityList;
  Map<int, E> _oidEntityMap;
  Map<String, E> _codeEntityMap;
  Map<String, E> _idEntityMap;
  Entities<E> _source;
  ValidationErrors _errors;

  String minc = '0';
  String maxc = 'N';
  bool pre = true;
  bool post = true;
  bool propagateToSource = true;
  Random randomGen = new Random();

  Entities() {
    _entityList = new List<E>();
    _oidEntityMap = new Map<int, E>();
    _codeEntityMap = new Map<String, E>();
    _idEntityMap = new Map<String, E>();
    _errors = new ValidationErrors();

    pre = false;
    post = false;
    propagateToSource = false;
  }

  Entities.of(this._concept) {
    _entityList = new List<E>();
    _oidEntityMap = new Map<int, E>();
    _codeEntityMap = new Map<String, E>();
    _idEntityMap = new Map<String, E>();
    _errors = new ValidationErrors();
  }

  Entities<E> newEntities() => new Entities.of(_concept);
  ConceptEntity<E> newEntity() => new ConceptEntity.of(_concept);


  E get first => _entityList.first;
  bool get isEmpty => _entityList.isEmpty;
  bool get isNotEmpty => _entityList.isNotEmpty;
  Iterator<E> get iterator => _entityList.iterator;
  E get last => _entityList.last;
  int get length => _entityList.length;
  int get count => length; // for my soul
  E get single => _entityList.single;

  Concept get concept => _concept;
  Entities<E> get source => _source;
  ValidationErrors get errors => _errors;


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
  set internalList(List<E> observableList) => _entityList = observableList;


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
      throw new ConceptError('Entities.copy: concept is not defined.');
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
    orderedEntities._source = this;
    return orderedEntities;
  }

  Entities<E> selectWhere(Function f) {
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.where(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities._source = this;
    return selectedEntities;
  }

  Entities<E> selectWhereAttribute(String code, Object attribute) {
    if (_concept == null) {
      throw new ConceptError(
        'Entities.selectByAttribute($code, $attribute): concept is not defined.');
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
    selectedEntities._source = this;
    return selectedEntities;
  }

  Entities<E> selectWhereParent(String code, EntityApi parent) {
    if (_concept == null) {
      throw new ConceptError(
        'Entities.selectByParent($code, $parent): concept is not defined.');
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
    selectedEntities._source = this;
    return selectedEntities;
  }

  Entities<E> skipFirst(int n) {
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.skip(n);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities._source = this;
    return selectedEntities;
  }

  Entities<E> skipFirstWhile(bool f(E entity)) {
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.skipWhile(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities._source = this;
    return selectedEntities;
  }

  Entities<E> takeFirst(int n) {
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.take(n);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities._source = this;
    return selectedEntities;
  }

  Entities<E> takeFirstWhile(bool f(E entity)) {
    Entities<E> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    var selectedElements = _entityList.takeWhile(f);
    selectedElements.forEach((entity) => selectedEntities.add(entity));
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities._source = this;
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
  
  fromJson(String entitiesJson) {
    List<Map<String, Object>> entitiesList = JSON.decode(entitiesJson);
    fromJsonList(entitiesList);
  }

  /**
   * Loads entities without validations to this, which must be empty.
   */
  fromJsonList(List<Map<String, Object>> entitiesList, 
               [ConceptEntity internalParent]) {
    if (concept == null) {
      throw new ConceptError('entities concept does not exist.');
    }
    if (length > 0) {
      throw new JsonError('entities are not empty');
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

  /**
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
    _errors.clear();
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
      throw new ConceptError(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptError('Entities.add: concept is not defined.');
    }
    if (!_concept.add) {
      throw new AddError('An entity cannot be added to ${_concept.codes}.');
    }

    bool result = true;

    // max validation
    if (maxc != 'N') {
      int maxInt;
      try {
        maxInt = int.parse(maxc);
        if (length == maxInt) {
          var error = new ValidationError('max');
          error.message = '${_concept.codes}.max is $maxc.';
          error.category = 'max cardinality';

          _errors.add(error);
          result = false;
        }
      } on FormatException catch (e) {
        throw new AddError(
          'Entities max is neither N nor a positive integer string.');
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
          throw new TypeError(
              '${a.code} attribute value cannot be incremented.');
        }
      } else if (a.required && entity.getAttribute(a.code) == null) {
        var error = new ValidationError('required');
        error.message = '${entity.concept.code}.${a.code} attribute is null.';
        _errors.add(error);
        result = false;
      }
    }
    for (Parent p in _concept.parents) {
      if (p.required && entity.getParent(p.code) == null) {
        var error = new ValidationError('required');
        error.message = '${entity.concept.code}.${p.code} parent is null.';
        _errors.add(error);
        result = false;
      }
    }

    // uniqueness validation
    if (entity.code != null && singleWhereCode(entity.code) != null) {
      var error = new ValidationError('unique');
      error.message = '${entity.concept.code}.code is not unique.';
      _errors.add(error);
      result = false;
    }
    if (entity.id != null && singleWhereId(entity.id) != null) {
      ValidationError error = new ValidationError('unique');
      error.message =
          '${entity.concept.code}.id ${entity.id.toString()} is not unique.';
      _errors.add(error);
      result = false;
    }

    return result;
  }

  bool add(E entity) {
    bool added = false;
    if (preAdd(entity)) {
      var propagated = true;
      if (_source != null && propagateToSource) {
        propagated = _source.add(entity);
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
            throw new RemoveError(msg);
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
        throw new AddError(msg);
      }
    }
    return added;
  }

  bool postAdd(E entity) {
    if (!post) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptError(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptError('Entities.add: concept is not defined.');
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
      throw new ConceptError(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptError('Entities.remove: concept is not defined.');
    }
    if (!_concept.remove) {
      throw new RemoveError(
        'An entity cannot be removed from ${_concept.codes}.');
    }

    bool result = true;

    // min validation
    if (minc != '0') {
      int minInt;
      try {
        minInt = int.parse(minc);
        if (length == minInt) {
          ValidationError error = new ValidationError('min');
          error.message = '${_concept.codes}.min is $minc.';
          _errors.add(error);
          result = false;
        }
      } on FormatException catch (e) {
        throw new RemoveError(
          'Entities min is not a positive integer string.');
      }
    }

    return result;
  }

  bool remove(E entity) {
    bool removed = false;
    if (preRemove(entity)) {
      var propagated = true;
      if (_source != null && propagateToSource) {
        propagated = _source.remove(entity);
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
              throw new AddError(msg);
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
        throw new RemoveError(msg);
      }
    }
    return removed;
  }

  bool postRemove(E entity) {
    if (!post) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptError(
        'Entity(oid: ${entity.oid}) concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptError('Entities.add: concept is not defined.');
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
      throw new UpdateError(
          '${_concept.codes}.update can only be used if oid, code or id set.');
    }
    if (remove(beforeEntity)) {
      if (add(afterEntity)) {
        afterEntity._whenUpdated = new DateTime.now();
        return true;
      } else {
        print('entities.update: ${errors.toList()}');
        if (add(beforeEntity)) {
          var error = new ValidationError('update');
          error.message =
            '${_concept.codes}.update fails to add after update entity.';
          _errors.add(error);
        } else {
          throw new UpdateError(
              '${_concept.codes}.update fails to add back before update entity.');
        }
      }
    } else {
      var error = new ValidationError('update');
      error.message =
        '${_concept.codes}.update fails to remove before update entity.';
      _errors.add(error);
    }
    return false;
  }

  bool addFrom(Entities<E> entities) {
    bool allAdded = true;
    if (_concept == entities.concept) {
      entities.forEach((entity) => add(entity) ? true : allAdded = false);
    } else {
      throw new ConceptError('The concept of the argument is different.');
    }
    return allAdded;
  }


  /**
  * Displays (prints) a title, then entities.
  */
  display({String title:'Entities', String prefix:'', bool withOid:true, 
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

  displayOidMap() {
    _oidEntityMap.forEach((k,v) {
      print('oid $k: $v');
    });
  }

  displayCodeMap() {
    _codeEntityMap.forEach((k,v) {
      print('code $k: $v');
    });
  }

  displayIdMap() {
    _idEntityMap.forEach((k,v) {
      print('id $k: $v');
    });
  }

}
