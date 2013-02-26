part of dartling;

abstract class EntitiesApi<T extends EntityApi<T>> {

  Concept get concept;
  EntitiesApi<T> get source;  ValidationErrorsApi get errors;
  int get length;
  bool get isEmpty;
  Iterator<T> get iterator;

  bool preAdd(T entity);
  bool add(T entity);
  bool postAdd(T entity);
  bool preRemove(T entity);
  bool remove(T entity);
  bool postRemove(T entity);

  bool any(Function f);
  bool contains(T entity);
  bool every(Function f);
  void forEach(Function f);

  T random();
  T find(Oid oid);
  T deepFind(Oid oid);
  T findByCode(String code);
  T findById(IdApi id);
  T findByAttributeId(String code, Object attribute);
  T findByAttribute(String code, Object attribute);

  EntitiesApi<T> select(Function f);
  EntitiesApi<T> selectByParent(String code, Object parent);
  EntitiesApi<T> selectByAttribute(String code, Object attribute);
  //EntitiesApi<T> order();
  void order();
  //EntitiesApi<T> orderByFunction(Function f);
  void orderByFunction(Function f);

  void clear();
  EntitiesApi<T> copy();
  List<T> toList();
  List<Map<String, Object>> toJson();

}

class Entities<T extends ConceptEntity<T>> implements EntitiesApi<T> {

  Concept _concept;
  List<T> _entityList;
  Map<int, T> _oidEntityMap;
  Map<String, T> _codeEntityMap;
  Map<String, T> _idEntityMap;
  Entities<T> _source;
  ValidationErrors _errors;

  String minc = '0';
  String maxc = 'N';
  bool pre = true;
  bool post = true;
  bool propagateToSource = true;

  Random randomGen;

  Entities() {
    _entityList = new List<T>();
    _oidEntityMap = new Map<int, T>();
    _codeEntityMap = new Map<String, T>();
    _idEntityMap = new Map<String, T>();
    _errors = new ValidationErrors();

    pre = false;
    post = false;
    propagateToSource = false;

    randomGen = new Random();
  }

  Entities.of(this._concept) {
    _entityList = new List<T>();
    _oidEntityMap = new Map<int, T>();
    _codeEntityMap = new Map<String, T>();
    _idEntityMap = new Map<String, T>();
    _errors = new ValidationErrors();

    randomGen = new Random();
  }

  Entities<T> newEntities() => new Entities.of(_concept);
  ConceptEntity<T> newEntity() => new ConceptEntity.of(_concept);

  Concept get concept => _concept;
  Entities<T> get source => _source;
  ValidationErrors get errors => _errors;
  bool get isEmpty => _entityList.isEmpty;
  Iterator<T> get iterator => _entityList.iterator;
  int get length => _entityList.length;
  T get first => _entityList.first;
  T get last => _entityList.last;

  bool any(Function f) => _entityList.any(f);

  bool contains(T entity) {
    T element = _oidEntityMap[entity.oid.timeStamp];
    if (entity == element) {
      return true;
    }
    return false;
  }

  bool every(Function f) => _entityList.every(f);
  void forEach(Function f) =>  _entityList.forEach(f);

  bool preAdd(T entity) {
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
    if (entity.code != null && findByCode(entity.code) != null) {
      var error = new ValidationError('unique');
      error.message = '${entity.concept.code}.code is not unique.';
      _errors.add(error);
      result = false;
    }
    if (entity.id != null && findById(entity.id) != null) {
      ValidationError error = new ValidationError('unique');
      error.message =
          '${entity.concept.code}.id ${entity.id.toString()} is not unique.';
      _errors.add(error);
      result = false;
    }

    return result;
  }

  bool add(T entity) {
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

  bool postAdd(T entity) {
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

  bool preRemove(T entity) {
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

  bool remove(T entity) {
    bool removed = false;
    if (preRemove(entity)) {
      for (T element in _entityList) {
        if (element == entity) {
          int index = _entityList.indexOf(element, 0);
          _entityList.removeRange(index, 1);
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

  bool postRemove(T entity) {
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
  bool update(T beforeEntity, T afterEntity) {
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

  T random() {
    if (!isEmpty) {
      return _entityList[randomGen.nextInt(length)];
    }
  }

  T find(Oid oid) {
    return _oidEntityMap[oid.timeStamp];
  }

  T deepFind(Oid oid) {
    if (isEmpty) {
      return null;
    }
    ConceptEntity foundEntity = find(oid);
    if (foundEntity != null) {
      return foundEntity;
    }
    if (!_concept.children.isEmpty) {
      for (ConceptEntity entity in _entityList) {
        for (Child child in _concept.children) {
          Entities childEntities = entity.getChild(child.code);
          return childEntities.deepFind(oid);
        }
      }
    }
  }

  T findByCode(String code) {
    return _codeEntityMap[code];
  }

  T findById(Id id) {
    return _idEntityMap[id.toString()];
  }

  T findByAttributeId(String code, Object attribute) {
    return findById(new Id(_concept)..setAttribute(code, attribute));
  }

  T findByAttribute(String code, Object attribute) {
    var selectionEntities = selectByAttribute(code, attribute);
    if (selectionEntities.length > 0) {
      return selectionEntities.first;
    }
    return null;
  }

  Entities<T> select(Function f) {
    Entities<T> selectedEntities = newEntities();
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

  Entities<T> selectByParent(String code, Object parent) {
    if (_concept == null) {
      throw new ConceptError(
        'Entities.selectByParent($code, $parent): concept is not defined.');
    }
    Entities<T> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    for (T entity in _entityList) {
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

  Entities<T> selectByAttribute(String code, Object attribute) {
    if (_concept == null) {
      throw new ConceptError(
        'Entities.selectByAttribute($code, $attribute): concept is not defined.');
    }
    Entities<T> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    for (T entity in _entityList) {
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

  /**
   * If there is no compareTo method on a specific entity,
   * the Entity.compareTo method will be used (code if not null, otherwise id).
   */
  /*
  Entities<T> order() {
    Entities<T> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.post = false;
    orderedEntities.propagateToSource = false;
    List<T> sortedList = toList();
    // in place sort
    sortedList.sort((m,n) => m.compareTo(n));
    sortedList.forEach((entity) => orderedEntities.add(entity));
    orderedEntities.pre = true;
    orderedEntities.post = true;
    orderedEntities.propagateToSource = false;
    orderedEntities._source = this;
    return orderedEntities;
  }
  */
  void order() {
    // in place sort
    _entityList.sort((m,n) => m.compareTo(n));
  }

  /*
  Entities<T> orderByFunction(Function f) {
    Entities<T> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.post = false;
    orderedEntities.propagateToSource = false;
    List<T> sortedList = toList();
    // in place sort
    sortedList.sort(f);
    sortedList.forEach((entity) => orderedEntities.add(entity));
    orderedEntities.pre = true;
    orderedEntities.post = true;
    orderedEntities.propagateToSource = false;
    orderedEntities._source = this;
    return orderedEntities;
  }
  */
  void orderByFunction(Function f) {
    // in place sort
    _entityList.sort(f);
  }

  /**
   * Copies the entities.
   * It is not a deep copy.
   */
  Entities<T> copy() {
    if (_concept == null) {
      throw new ConceptError('Entities.copy: concept is not defined.');
    }
    Entities<T> copiedEntities = newEntities();
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

  bool addFrom(Entities<T> entities) {
    bool allAdded = true;
    if (_concept == entities.concept) {
      entities.forEach((entity) => add(entity) ? true : allAdded = false);
    } else {
      throw new ConceptError('The concept of the argument is different.');
    }
    return allAdded;
  }

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
    for (T e in _entityList) {
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

  void clear() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
    _idEntityMap.clear();
    _errors.clear();
  }

  List<T> toList() => _entityList.toList();

  List<Map<String, Object>> toJson() {
    List<Map<String, Object>> entityList = new List<Map<String, Object>>();
    for (T entity in _entityList) {
      entityList.add(entity.toJson());
    }
    return entityList;
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
      T entity = newEntity();
      entity.fromJson(entityMap);
      pre = false;
      post = false;
      add(entity);
      pre = true;
      post = true;
    }
  }

}
