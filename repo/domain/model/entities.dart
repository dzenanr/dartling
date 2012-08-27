
abstract class EntitiesApi<T extends EntityApi<T>> implements Iterable<T> {

  abstract Concept get concept();
  abstract EntitiesApi<T> get source();
  abstract ErrorsApi get errors();
  abstract int get count();
  abstract bool get empty();
  abstract void clear();

  abstract bool preAdd(T entity);
  abstract bool add(T entity);
  abstract bool postAdd(T entity);
  abstract bool preRemove(T entity);
  abstract bool remove(T entity);
  abstract bool postRemove(T entity);

  abstract void forEach(Function f);
  abstract bool every(Function f);
  abstract bool some(Function f);

  abstract bool contains(T entity);
  abstract T last();
  abstract T find(Oid oid);
  abstract T deepFind(Oid oid);
  abstract T findByCode(String code);
  abstract T findById(IdApi id);
  abstract T findByAttributeId(String code, Object attribute);
  abstract T findByAttribute(String code, Object attribute);

  abstract EntitiesApi<T> select(Function f);
  abstract EntitiesApi<T> selectByParent(String code, Object parent);
  abstract EntitiesApi<T> selectByAttribute(String code, Object attribute);
  abstract EntitiesApi<T> order();
  abstract EntitiesApi<T> orderByFunction(Function f);

  abstract EntitiesApi<T> copy();
  abstract List<T> get list();
  abstract List<Map<String, Object>> toJson();

}

class Entities<T extends ConceptEntity<T>> implements EntitiesApi<T> {

  Concept _concept;
  List<T> _entityList;
  Map<int, T> _oidEntityMap;
  Map<String, T> _codeEntityMap;
  Map<String, T> _idEntityMap;
  Entities<T> _source;
  Errors _errors;

  String minc = '0';
  String maxc = 'N';
  bool pre = true;
  bool post = true;
  bool propagateToSource = true;

  Entities() {
    _entityList = new List<T>();
    _oidEntityMap = new Map<int, T>();
    _codeEntityMap = new Map<String, T>();
    _idEntityMap = new Map<String, T>();
    _errors = new Errors();

    pre = false;
    post = false;
    propagateToSource = false;
  }

  Entities.of(this._concept) {
    _entityList = new List<T>();
    _oidEntityMap = new Map<int, T>();
    _codeEntityMap = new Map<String, T>();
    _idEntityMap = new Map<String, T>();
    _errors = new Errors();
  }

  Entities<T> newEntities() => new Entities.of(_concept);

  Concept get concept() => _concept;
  Entities<T> get source() => _source;
  Errors get errors() => _errors;
  int get count() => _entityList.length;
  int get length() => count;
  bool get empty() => _entityList.isEmpty();

  void clear() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
    _idEntityMap.clear();
    _errors.clear();
  }

  Iterator<T> iterator() => _entityList.iterator();

  void forEach(Function f) {
    _entityList.forEach(f);
  }

  bool every(Function f) {
    return _entityList.every(f);
  }

  bool some(Function f) {
    return _entityList.some(f);
  }

  bool preAdd(T entity) {
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
      throw new AddException(
        'An entity cannot be added to ${_concept.codePlural}.');
    }

    bool result = true;

    // max validation
    if (maxc != 'N') {
      int maxInt;
      try {
        maxInt = Math.parseInt(maxc);
        if (count == maxInt) {
          Error error = new Error('max');
          error.message = '${_concept.code}.max is $maxc.';
          _errors.add(error);
          result = false;
        }
      } catch (final FormatException e) {
        throw new AddException(
          'Entities max is neither N nor a positive integer string.');
      }
    }

    // increment and required validation
    for (Attribute a in _concept.attributes) {
      if (a.increment != null) {
        if (count == 0) {
          entity.setAttribute(a.code, a.increment);
        } else if (a.type.base == 'int') {
          var lastEntity = last();
          int incrementAttribute = lastEntity.getAttribute(a.code);
          entity.setAttribute(a.code, incrementAttribute + a.increment);
        } else {
          throw new TypeException(
              '${a.code} attribute value cannot be incremented.');
        }
      } else if (a.required && entity.getAttribute(a.code) == null) {
        Error error = new Error('required');
        error.message = '${entity.concept.code}.${a.code} attribute is null.';
        _errors.add(error);
        result = false;
      }
    }
    for (Parent p in _concept.parents) {
      if (p.required && entity.getParent(p.code) == null) {
        Error error = new Error('required');
        error.message = '${entity.concept.code}.${p.code} parent is null.';
        _errors.add(error);
        result = false;
      }
    }

    // uniqueness validation
    if (entity.code != null && findByCode(entity.code) != null) {
      Error error = new Error('unique');
      error.message = '${entity.concept.code}.code is not unique.';
      _errors.add(error);
      result = false;
    }
    if (entity.id != null && findById(entity.id) != null) {
      Error error = new Error('unique');
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
          throw new RemoveException(msg);
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

  bool preRemove(T entity) {
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
        'An entity cannot be removed from ${_concept.codePlural}.');
    }

    bool result = true;

    // min validation
    if (minc != '0') {
      int minInt;
      try {
        minInt = Math.parseInt(minc);
        if (count == minInt) {
          Error error = new Error('min');
          error.message = '${_concept.code}.min is $minc.';
          _errors.add(error);
          result = false;
        }
      } catch (final FormatException e) {
        throw new RemoveException(
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
          throw new AddException(msg);
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

  bool contains(T entity) {
    T element = _oidEntityMap[entity.oid.timeStamp];
    if (entity == element) {
      return true;
    }
    return false;
  }

  T last() {
    return _entityList.last();
  }

  T find(Oid oid) {
    return _oidEntityMap[oid.timeStamp];
  }

  T deepFind(Oid oid) {
    if (empty) {
      return null;
    }
    ConceptEntity foundEntity = find(oid);
    if (foundEntity != null) {
      return foundEntity;
    }
    if (!_concept.children.empty) {
      for (ConceptEntity entity in _entityList) {
        for (Child child in _concept.children) {
          Entities childEntities = entity.getChild(child.code);
          return childEntities.deepFind(oid);
        }
      }
    }
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
      throw new UpdateException(
          '${_concept.codePlural}.update can only be used '
          'if oid, code or id set.');
    }
    if (remove(beforeEntity)) {
      if (add(afterEntity)) {
        return true;
      } else {
        if (add(beforeEntity)) {
          Error error = new Error('update');
          error.message =
            '${_concept.codePlural}.update fails to add after update entity.';
          _errors.add(error);
        } else {
          throw new UpdateException(
              '${_concept.codePlural}.update fails '
              'to add back before update entity.');
        }
      }
    } else {
      Error error = new Error('update');
      error.message =
        '${_concept.codePlural}.update fails to remove before update entity.';
      _errors.add(error);
    }
    return false;
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
    if (selectionEntities.count > 0) {
      return selectionEntities.list[0];
    }
    return null;
  }

  Entities<T> select(Function f) {
    Entities<T> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.post = false;
    selectedEntities.propagateToSource = false;
    // filter returns a new list
    List<T> selectedList = _entityList.filter(f);
    selectedEntities._addFromList(selectedList);
    selectedEntities.pre = true;
    selectedEntities.post = true;
    selectedEntities.propagateToSource = true;
    selectedEntities._source = this;
    return selectedEntities;
  }

  Entities<T> selectByParent(String code, Object parent) {
    if (_concept == null) {
      throw new ConceptException(
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
      throw new ConceptException(
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
  Entities<T> order() {
    Entities<T> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.post = false;
    orderedEntities.propagateToSource = false;
    List<T> sortedList = list;
    // in place sort
    sortedList.sort((m,n) => m.compareTo(n));
    orderedEntities._addFromList(sortedList);
    orderedEntities.pre = true;
    orderedEntities.post = true;
    orderedEntities.propagateToSource = false;
    orderedEntities._source = this;
    return orderedEntities;
  }

  Entities<T> orderByFunction(Function f) {
    Entities<T> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.post = false;
    orderedEntities.propagateToSource = false;
    List<T> sortedList = list;
    // in place sort
    sortedList.sort(f);
    orderedEntities._addFromList(sortedList);
    orderedEntities.pre = true;
    orderedEntities.post = true;
    orderedEntities.propagateToSource = false;
    orderedEntities._source = this;
    return orderedEntities;
  }

  /**
   * Copies the entities.
   * It is not a deep copy.
   */
  Entities<T> copy() {
    if (_concept == null) {
      throw new ConceptException('Entities.copy: concept is not defined.');
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

  _addFromList(List<T> other) {
    other.forEach((entity) => add(entity));
  }

  bool addFrom(Entities<T> entities) {
    bool allAdded = true;
    if (_concept == entities.concept) {
      entities.forEach((entity) => add(entity) ? true : allAdded = false);
    } else {
      throw new ConceptException('The concept of the argument is different.');
    }
    return allAdded;
  }

  List<T> get list() => new List.from(_entityList);

  /**
  * Displays (prints) a title, then entities.
  */
  display([String title='Entities', String space='', bool withOid=true, bool withChildren=true]) {
    var s = space;
    if (!_concept.entry || (_concept.entry && _concept.parents.count > 0)) {
      s = '$space  ';
    }
    if (title != '') {
      //print('');
      print('${s}======================================');
      print('${s}$title                                ');
      print('${s}======================================');
      //print('');
    }
    for (T e in _entityList) {
      e.display(s, withOid, withChildren);
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

  List<Map<String, Object>> toJson() {
    List<Map<String, Object>> entityList = new List<Map<String, Object>>();
    for (ConceptEntity entity in _entityList) {
      entityList.add(entity.toJson());
    }
    return entityList;
  }

}
