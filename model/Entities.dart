
class Entities<T extends Entity<T>> implements Iterable<Entity> {

  Concept _concept;

  List<T> _entityList;
  Map<Oid, T> _oidEntityMap;
  Map<String, T> _codeEntityMap;

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

    propagateToSource = false;
    pre = false;
  }

  Entities.of(this._concept) {
    _entityList = new List<T>();
    _oidEntityMap = new Map<Oid, T>();
    _codeEntityMap = new Map<String, T>();
  }

  Concept get concept() => _concept;

  Iterator<T> iterator() => _entityList.iterator();

  int get count() => _entityList.length;

  bool get isEmpty() => _entityList.isEmpty();

  bool preAdd(T entity) {
    if (errors == null) {
      errors = new Errors();
    }

    if (!pre) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptException('Entities concept is not defined.');
    }
    if (!_concept.add) {
      throw new AddException('An entity cannot be added to ${_concept.pluralName}.');
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
        throw new AddException('Entities max is neither N nor a positive integer string.');
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
    if (entity.code != null && getEntityByCode(entity.code) != null) {
      Error error = new Error('unique');
      error.message = '${entity.concept.code}.code is not unique.';
      errors.add(error);
      validation = false;
    }
    if (entity.id != null && getEntityById(entity.id) != null) {
      Error error = new Error('unique');
      error.message = '${entity.concept.code}.id ${entity.id.toString()} is not unique.';
      errors.add(error);
      validation = false;
    }

    return validation;
  }

  add(T entity) {
    if (preAdd(entity)) {
      _entityList.add(entity);
      _oidEntityMap[entity.oid] = entity;
      if (entity.code != null) {
        _codeEntityMap[entity.code] = entity;
      }

      if (sourceEntities != null && propagateToSource) {
        sourceEntities.add(entity);
      }
    }
  }

  bool contains(T entity) {
    T element = _oidEntityMap[entity.oid];
    if (entity == element) {
      return true;
    }
    return false;
  }

  empty() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
  }

  bool preRemove(T entity) {
    if (!pre) {
      return true;
    }

    if (entity.concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    if (_concept == null) {
      throw new ConceptException('Entities concept is not defined.');
    }
    if (!_concept.remove) {
      throw new RemoveException('An entity cannot be removed from ${_concept.pluralName}.');
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
        throw new RemoveException('Entities min is not a positive integer string.');
      }
    }

    return validation;
  }

  remove(T entity) {
    if (preRemove(entity)) {
      for (T element in _entityList) {
        if (element == entity) {
          int index = _entityList.indexOf(element, 0);
          _entityList.removeRange(index, 1);
          _oidEntityMap.remove(entity.oid);
          if (entity.code != null) {
            _codeEntityMap.remove(entity.code);
          }
          break;
        }
      }

      if (sourceEntities != null && propagateToSource) {
        sourceEntities.remove(entity);
      }
    }
  }

  T getEntity(Oid oid) {
    return _oidEntityMap[oid];
  }

  T getEntityByCode(String code) {
    if (_codeEntityMap.containsKey(code)) {
      return _codeEntityMap[code];
    } else {
      for (T element in _entityList) {
        if (element.code == code) {
         return element;
        }
      }
      return null;
    }
  }

  T getEntityById(Id id) {
    if (id.count == 0) {
      return null;
    }
    if (_concept == null) {
      throw new ConceptException('Entities concept is not defined.');
    }
    for (T entity in _entityList) {
      var found = true;
      if (id.parentCount > 0) {
        for (Parent p in _concept.parents) {
          if (p.id) {
            if (entity.getParent(p.code) != id.getIdParent(p.code)) {
              found = false;
              break;
            }
          }
        }
      }
      if (found && id.attributeCount > 0) {
        for (Attribute a in _concept.attributes) {
          if (a.id) {
            if (entity.getAttribute(a.code) != id.getIdAttribute(a.code)) {
              found = false;
              break;
            }
          }
        }
      }
      if (found) {
        return entity;
      }
    }
    return null;
  }

  addFrom(List<T> other) {
    other.forEach((entity) => add(entity));
  }

  List<T> getList() => new List.from(_entityList);

  List<T> select(Function f) {
    // returns a new list
    return _entityList.filter(f);
  }

  List<T> selectByAttribute(String code, Object attribute) {
    if (_concept == null) {
      throw new ConceptException('Entities concept is not defined.');
    }
    var selectionList = new List<T>();
    for (T entity in _entityList) {
      for (Attribute a in _concept.attributes) {
        if (a.code == code) {
          if (entity.getAttribute(a.code) == attribute) {
            selectionList.add(entity);
          }
        }
      }
    }
    return selectionList;
  }

  T getEntityByAttribute(String code, Object attribute) {
    var selectionList = selectByAttribute(code, attribute);
    if (selectionList.length > 0) {
      return selectionList[0];
    }
    return null;
  }

  List<T> selectByParent(String code, Object parent) {
    if (_concept == null) {
      throw new ConceptException('Entities concept is not defined.');
    }
    var selectionList = new List<T>();
    for (T entity in _entityList) {
      for (Parent p in _concept.parents) {
        if (p.code == code) {
          if (entity.getParent(p.code) == parent) {
            selectionList.add(entity);
          }
        }
      }
    }
    return selectionList;
  }

  List<T> order(Function f) {
    List<T> sortedList = getList();
    sortedList.sort(f);
    return sortedList;
  }

  List<T> orderByCode() {
    List<T> sortedList = getList();
    sortedList.sort((m,n) => m.compareTo(n));
    return sortedList;
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

}
