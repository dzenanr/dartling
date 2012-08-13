
abstract class EntitiesApi<T extends EntityApi<T>> implements Iterable<T> {

  abstract EntitiesApi<T> newEntities();
  abstract Concept get concept();
  abstract EntitiesApi<T> get source();
  abstract ErrorsApi get errors();
  abstract int get count();
  abstract bool get empty();

  abstract bool preAdd(T entity);
  abstract bool add(T entity);
  abstract bool preRemove(T entity);
  abstract bool remove(T entity);

  abstract void forEach(Function f);
  abstract bool every(Function f);
  abstract bool some(Function f);

  abstract bool contains(T entity);
  abstract T last();
  abstract T find(Oid oid);
  abstract T findByCode(String code);
  abstract T findById(IdApi id);
  abstract T findByAttributeId(String code, Object attribute);
  abstract T findByAttribute(String code, Object attribute);

  abstract EntitiesApi<T> select(Function f);
  abstract EntitiesApi<T> selectByParent(String code, Object parent);
  abstract EntitiesApi<T> selectByAttribute(String code, Object attribute);
  abstract EntitiesApi<T> order();
  abstract EntitiesApi<T> orderByFunction(Function f);

  abstract void clear();
  abstract EntitiesApi<T> copy();
  abstract List<T> get list();

  abstract List<Map<String, Object>> toJson();

}

class Entities<T extends Entity<T>> implements EntitiesApi<T> {

  Concept _concept;
  List<T> _entityList;
  Map<Oid, T> _oidEntityMap;
  Map<String, T> _codeEntityMap;
  Map<String, T> _idEntityMap;
  Entities<T> _source;
  Errors _errors;

  String min = '0';
  String max = 'N';
  bool pre = true;
  bool propagateToSource = true;

  Entities() {
    _entityList = new List<T>();
    _oidEntityMap = new Map<Oid, T>();
    _codeEntityMap = new Map<String, T>();
    _idEntityMap = new Map<String, T>();

    propagateToSource = false;
    pre = false;
  }

  Entities.of(this._concept) {
    _entityList = new List<T>();
    _oidEntityMap = new Map<Oid, T>();
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
        'An entity cannot be added to ${_concept.plural}.');
    }

    bool validation = true;

    // max validation
    if (max != 'N') {
      int maxInt;
      try {
        maxInt = Math.parseInt(max);
        if (count == maxInt) {
          Error error = new Error('max');
          error.message = '${_concept.code}.max is $max.';
          _errors.add(error);
          validation = false;
        }
      } catch (final BadNumberFormatException e) {
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
          var incrementAttribute = lastEntity.getAttribute(a.code);
          entity.setAttribute(a.code, incrementAttribute + a.increment);
        } else {
          throw new TypeException(
              '${a.code} attribute value cannot be incremented.');
        }
      } else if (a.required && entity.getAttribute(a.code) == null) {
        Error error = new Error('required');
        error.message = '${entity.concept.code}.${a.code} attribute is null.';
        _errors.add(error);
        validation = false;
      }
    }
    for (Parent p in _concept.parents) {
      if (p.required && entity.getParent(p.code) == null) {
        Error error = new Error('required');
        error.message = '${entity.concept.code}.${p.code} parent is null.';
        _errors.add(error);
        validation = false;
      }
    }

    // uniqueness validation
    if (entity.code != null && findByCode(entity.code) != null) {
      Error error = new Error('unique');
      error.message = '${entity.concept.code}.code is not unique.';
      _errors.add(error);
      validation = false;
    }
    if (entity.id != null && findById(entity.id) != null) {
      Error error = new Error('unique');
      error.message =
          '${entity.concept.code}.id ${entity.id.toString()} is not unique.';
      _errors.add(error);
      validation = false;
    }

    return validation;
  }

  bool add(T entity) {
    if (preAdd(entity)) {
      _entityList.add(entity);
      _oidEntityMap[entity.oid] = entity;
      if (entity.code != null) {
        _codeEntityMap[entity.code] = entity;
      }
      if (entity.concept != null && entity.id != null) {
        _idEntityMap[entity.id.toString()] = entity;
      }

      if (_source != null && propagateToSource) {
        _source.add(entity);
      }
      return true;
    }
    return false;
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
        'An entity cannot be removed from ${_concept.plural}.');
    }

    bool validation = true;

    // min validation
    if (min != '0') {
      int minInt;
      try {
        minInt = Math.parseInt(min);
        if (count == minInt) {
          Error error = new Error('min');
          error.message = '${_concept.code}.min is $min.';
          _errors.add(error);
          validation = false;
        }
      } catch (final BadNumberFormatException e) {
        throw new RemoveException(
          'Entities min is not a positive integer string.');
      }
    }

    return validation;
  }

  bool remove(T entity) {
    if (preRemove(entity)) {
      for (T element in _entityList) {
        if (element == entity) {
          int index = _entityList.indexOf(element, 0);
          _entityList.removeRange(index, 1);
          _oidEntityMap.remove(entity.oid);
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
      return true;
    }
    return false;
  }

  bool contains(T entity) {
    T element = _oidEntityMap[entity.oid];
    if (entity == element) {
      return true;
    }
    return false;
  }

  T last() {
    return _entityList.last();
  }

  T find(Oid oid) {
    return _oidEntityMap[oid];
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
    selectedEntities.propagateToSource = false;
    // filter returns a new list
    List<T> selectedList = _entityList.filter(f);
    selectedEntities._addFromList(selectedList);
    selectedEntities.pre = true;
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
    orderedEntities.propagateToSource = false;
    List<T> sortedList = list;
    // in place sort
    sortedList.sort((m,n) => m.compareTo(n));
    orderedEntities._addFromList(sortedList);
    orderedEntities.pre = true;
    orderedEntities.propagateToSource = false;
    orderedEntities._source = this;
    return orderedEntities;
  }

  Entities<T> orderByFunction(Function f) {
    Entities<T> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.propagateToSource = false;
    List<T> sortedList = list;
    // in place sort
    sortedList.sort(f);
    orderedEntities._addFromList(sortedList);
    orderedEntities.pre = true;
    orderedEntities.propagateToSource = false;
    orderedEntities._source = this;
    return orderedEntities;
  }

  void clear() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
    _idEntityMap.clear();
    _errors.clear();
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
    for (Entity entity in this) {
      copiedEntities.add(entity.copy());
    }
    copiedEntities.pre = true;
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
  display([String title='Entities', bool withOid=true, bool withChildren=true]) {
    if (title != '') {
      print('');
      print('======================================');
      print('$title                                ');
      print('======================================');
      print('');
    }
    for (T e in _entityList) {
      e.display('', withOid, withChildren);
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
    for (Entity entity in _entityList) {
      entityList.add(entity.toJson());
    }
    return entityList;
  }

}
