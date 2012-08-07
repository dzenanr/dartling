
class Entities<T extends Entity<T>> implements Iterable<Entity> {

  Concept _concept;

  List<T> _entityList;
  Map<Oid, T> _oidEntityMap;
  Map<String, T> _codeEntityMap;
  Map<String, T> _idEntityMap;

  Entities<T> sourceEntities;
  bool propagateToSource = true;

  String min = '0';
  String max = 'N';

  num lastIncrement = 0;

  bool pre = true;
  Errors errors;

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
  }

  Entities<T> newEntities() => new Entities.of(_concept);

  Concept get concept() => _concept;

  Iterator<T> iterator() => _entityList.iterator();

  forEach(Function f) {
    _entityList.forEach(f);
  }

  every(Function f) {
    return _entityList.every(f);
  }

  some(Function f) {
    return _entityList.some(f);
  }

  int get count() => _entityList.length;
  int get length() => count;

  bool get empty() => _entityList.isEmpty();

  T last() {
    return _entityList.last();
  }

  bool preAdd(T entity) {
    if (errors == null) {
      errors = new Errors();
    }

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
        'An entity cannot be added to ${_concept.pluralName}.');
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
          errors.add(error);
          validation = false;
        }
      } catch (final BadNumberFormatException e) {
        throw new AddException(
          'Entities max is neither N nor a positive integer string.');
      }
    }

    // required validation
    for (Attribute a in _concept.attributes) {
      if (a.increment != null) {
        print('attribute increment');
        lastIncrement == lastIncrement + a.increment;
        entity.setAttribute(a.code, lastIncrement);
      } else if (a.required && entity.getAttribute(a.code) == null) {
        Error error = new Error('required');
        error.message = '${entity.concept.code}.${a.code} attribute is null.';
        errors.add(error);
        validation = false;
      }
    }
    for (Parent p in _concept.parents) {
      if (p.required && entity.getParent(p.code) == null) {
        Error error = new Error('required');
        error.message = '${entity.concept.code}.${p.code} parent is null.';
        errors.add(error);
        validation = false;
      }
    }

    // uniqueness validation
    if (entity.code != null && findByCode(entity.code) != null) {
      Error error = new Error('unique');
      error.message = '${entity.concept.code}.code is not unique.';
      errors.add(error);
      validation = false;
    }
    if (entity.id != null && findById(entity.id) != null) {
      Error error = new Error('unique');
      error.message =
          '${entity.concept.code}.id ${entity.id.toString()} is not unique.';
      errors.add(error);
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

      if (sourceEntities != null && propagateToSource) {
        sourceEntities.add(entity);
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

  clear() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
    _idEntityMap.clear();
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
        'An entity cannot be removed from ${_concept.pluralName}.');
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
      if (sourceEntities != null && propagateToSource) {
        sourceEntities.remove(entity);
      }
      return true;
    }
    return false;
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
    return findById(new Id(concept)..setAttribute('code', attribute));
  }

  T findByAttribute(String code, Object attribute) {
    var selectionEntities = selectByAttribute(code, attribute);
    if (selectionEntities.count > 0) {
      return selectionEntities.list[0];
    }
    return null;
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

  addFrom(List<T> other) {
    other.forEach((entity) => add(entity));
  }

  List<T> get list() => new List.from(_entityList);

  Entities<T> select(Function f) {
    Entities<T> selectedEntities = newEntities();
    selectedEntities.pre = false;
    selectedEntities.propagateToSource = false;
    // filter returns a new list
    List<T> selectedList = _entityList.filter(f);
    selectedEntities.addFrom(selectedList);
    selectedEntities.pre = true;
    selectedEntities.propagateToSource = true;
    selectedEntities.sourceEntities = this;
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
    selectedEntities.sourceEntities = this;
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
    selectedEntities.sourceEntities = this;
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
    orderedEntities.addFrom(sortedList);
    orderedEntities.pre = true;
    orderedEntities.propagateToSource = false;
    orderedEntities.sourceEntities = this;
    return orderedEntities;
  }

  Entities<T> orderByFunction(Function f) {
    Entities<T> orderedEntities = newEntities();
    orderedEntities.pre = false;
    orderedEntities.propagateToSource = false;
    List<T> sortedList = list;
    // in place sort
    sortedList.sort(f);
    orderedEntities.addFrom(sortedList);
    orderedEntities.pre = true;
    orderedEntities.propagateToSource = false;
    orderedEntities.sourceEntities = this;
    return orderedEntities;
  }

  /**
  * Displays (prints) a title, then entities.
  */
  display([String title='Entities', bool withOid=true]) {
    if (title != '') {
      print('');
      print('======================================');
      print('$title                                ');
      print('======================================');
      print('');
    }
    for (T e in _entityList) {
      e.display('', withOid);
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
