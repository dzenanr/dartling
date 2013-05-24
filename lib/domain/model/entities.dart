part of dartling;

abstract class EntitiesApi<E extends EntityApi<E>> {

  final Concept concept;
  final ValidationErrorsApi errors;
  final bool isEmpty;
  final int length;
  final EntitiesApi<E> source;
  final Iterator<E> iterator;

  bool preAdd(E entity);
  bool add(E entity);
  bool postAdd(E entity);
  bool preRemove(E entity);
  bool remove(E entity);
  bool postRemove(E entity);

  bool contains(E entity);
  bool any(bool f(E entity));
  bool every(bool f(E entity));

  E singleWhereOid(Oid oid);
  E singleDownWhereOid(Oid oid);
  E singleWhereCode(String code);
  E singleWhereId(IdApi id);
  E singleWhereAttributeId(String code, Object attribute);
  E firstWhereAttribute(String code, Object attribute);
  E random();

  EntitiesApi<E> copy();
  EntitiesApi<T> order([int compare(E a, E b)]);
  EntitiesApi<E> selectWhere(bool f(E entity));
  EntitiesApi<E> selectWhereAttribute(String code, Object attribute);
  EntitiesApi<E> selectWhereParent(String code, EntityApi parent);

  void clear();
  void forEach(bool f(E entity));
  void sort([int compare(E a, E b)]); // in place sort

  List<Map<String, Object>> toJson();
  List<E> toList();

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


  Concept get concept => _concept;
  ValidationErrors get errors => _errors;
  bool get isEmpty => _entityList.isEmpty;
  int get length => _entityList.length;
  Entities<E> get source => _source;
  Iterator<E> get iterator => _entityList.iterator;

  E get first => _entityList.first;
  E get last => _entityList.last;


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
        } else if (a.type.base == 'int') {
          var lastEntity = last;
          int incrementAttribute = lastEntity.getAttribute(a.code);
          entity.setAttribute(a.code, incrementAttribute + a.increment);
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
      _entityList.add(entity);
      _oidEntityMap[entity.oid.timeStamp] = entity;
      if (entity.code != null) {
        _codeEntityMap[entity.code] = entity;
      }
      if (entity.concept != null && entity.id != null) {
        _idEntityMap[entity.id.toString()] = entity;
      }

      if (_source != null && propagateToSource) {
        _source.add(entity);
      }
      if (postAdd(entity)) {
        added = true;
      } else {
        var beforePre = pre;
        var beforePost = post;
        pre = false;
        post = false;
        if (!remove(entity)) {
          var msg = '${entity.concept.code} entity (${entity.oid}) '
            'was added, post was not successful, remove was not successful';
          throw new RemoveError(msg);
        }
        pre = beforePre;
        post = beforePost;
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
      for (E element in _entityList) {
        if (element == entity) {
          _entityList.remove(entity);
          _oidEntityMap.remove(entity.oid.timeStamp);
          if (entity.code != null) {
            _codeEntityMap.remove(entity.code);
          }
          if (entity.concept != null && entity.id != null) {
            _idEntityMap.remove(entity.id.toString());
          }
          break;
        }
      }
      if (_source != null && propagateToSource) {
        _source.remove(entity);
      }
      if (postRemove(entity)) {
        removed = true;
      } else {
        var beforePre = pre;
        var beforePost = post;
        pre = false;
        post = false;
        if (!add(entity)) {
          var msg = '${entity.concept.code} entity (${entity.oid}) '
            'was removed, post was not successful, add was not successful';
          throw new AddError(msg);
        }
        pre = beforePre;
        post = beforePost;
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
        return true;
      } else {
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


  bool any(bool f(E entity)) => _entityList.any(f);

  bool contains(E entity) {
    E element = _oidEntityMap[entity.oid.timeStamp];
    if (entity == element) {
      return true;
    }
    return false;
  }

  bool every(bool f(E entity)) => _entityList.every(f);


  E singleWhereOid(Oid oid) {
    return _oidEntityMap[oid.timeStamp];
  }

  E singleDownWhereOid(Oid oid) {
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
          Entities childEntities = entity.getChild(child.code);
          return childEntities.singleDownWhereOid(oid);
        }
      }
    }
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
    if (?compare) {
      sortedList.sort(compare);
    } else {
      sortedList.sort((m,n) => m.compareTo(n));
    }
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

  Entities<E> selectByParent(String code, EntityApi parent) {
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


  void clear() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
    _idEntityMap.clear();
    _errors.clear();
  }

  void forEach(bool f(E entity)) =>  _entityList.forEach(f);

  /**
   * If compare function is not passed, compareTo method will be used.
   * If there is no compareTo method on specific entity,
   * the Entity.compareTo method will be used (code if not null, otherwise id).
   */
  void sort([int compare(E a, E b)]) {
    // in place sort
    if (?compare) {
      _entityList.sort(compare);
    } else {
      _entityList.sort((m,n) => m.compareTo(n));
    }
  }


  /**
   * Loads entities without validations to this, which must be empty.
   * It does not handle neighbors.
   * See ModelEntries for the JSON transfer at the level of a model.
   */
  fromJson(List<Map<String, Object>> entitiesList) {
    if (concept == null) {
      throw new ConceptError('entities concept does not exist.');
    }
    if (length > 0) {
      throw new JsonError('entities are not empty');
    }
    for (Map<String, Object> entityMap in entitiesList) {
      E entity = newEntity();
      entity.fromJson(entityMap);
      pre = false;
      post = false;
      add(entity);
      pre = true;
      post = true;
    }
  }

  List<Map<String, Object>> toJson() {
    List<Map<String, Object>> entityList = new List<Map<String, Object>>();
    for (E entity in _entityList) {
      entityList.add(entity.toJson());
    }
    return entityList;
  }

  List<E> toList() => _entityList.toList();

  /**
   * Returns a string that represents this entity by using oid and code.
   */
  String toString() {
    if (_concept != null) {
      return '${_concept.code}: entities:${length}';
    } else {
      print('Entities.toString(): entities concept is null.');
    }
  }


  /**
  * Displays (prints) a title, then entities.
  */
  display({String title:'Entities', String prefix:'',
      bool withOid:true, bool withChildren:true}) {
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
      e.display(prefix:s, withOid:withOid, withChildren:withChildren);
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
