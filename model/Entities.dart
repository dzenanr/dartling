
class Entities<T extends Entity<T>> implements Iterable<Entity> {

  Concept _concept;

  List<T> _entityList;
  Map<Oid, T> _oidEntityMap;
  Map<String, T> _codeEntityMap;

  Entities<T> sourceEntities;
  bool propagateToSource = true;

  Entities() {
    _entityList = new List<T>();
    _oidEntityMap = new Map<Oid, T>();
    _codeEntityMap = new Map<String, T>();
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

  add(T entity) {
    _entityList.add(entity);
    _oidEntityMap[entity.oid] = entity;
    if (entity.code != null) {
      if (_codeEntityMap.containsKey(entity.code)) {
        if (_codeEntityMap[entity.code] != null) {
          throw new IllegalArgumentException('Entity code must be unique.');
        }
      }
      _codeEntityMap[entity.code] = entity;
    }
    if (sourceEntities != null && propagateToSource) {
      sourceEntities.add(entity);
    }
  }

  bool contains(T entity) {
    T element = _oidEntityMap[entity.oid];
    if (entity == element) {
      return true;
    }
    /*
    if (entity.code != null) {
      if(_codeEntityMap.containsKey(entity.code)) {
        T element = _codeEntityMap[entity.code];
        if (element == entity) {
          return true;
        }
      }
    } else {
      for (T element in _entityList) {
        if (element == entity) {
          return true;
        }
      }
    }
    */
    return false;
  }

  empty() {
    _entityList.clear();
    _oidEntityMap.clear();
    _codeEntityMap.clear();
  }

  remove(T entity) {
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

  List<T> selectByFunction(Function f) {
    // returns a new list
    return _entityList.filter(f);
  }

  List<T> selectByAttribute(String code, Object attribute) {
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

  List<T> selectByParent(String code, Object parent) {
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

  /**
  * Displays (prints) a title, then entities.
  */
  display([String title='Data', bool withOid=true]) {
    if (title != '') {
      print('');
      print('**************************************');
      print('$title                                  ');
      print('**************************************');
      print('');
    }
    for (T e in _entityList) {
      e.display('', withOid);
    }
  }

}
