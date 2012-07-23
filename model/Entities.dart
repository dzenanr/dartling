
class Entities<T extends Entity<T>> implements Iterable<Entity> {

  Concept _concept;

  List<T> _entityList;
  Map<String, T> _entityMap;

  Entities<T> sourceEntities;
  bool propagateToSource = true;

  Entities() {
    _entityList = new List<T>();
    _entityMap = new Map<String, T>();
  }

  Entities.of(this._concept) {
    _entityList = new List<T>();
    _entityMap = new Map<String, T>();
  }

  Concept get concept() => _concept;

  Iterator<T> iterator() => _entityList.iterator();

  int get count() => _entityList.length;

  bool get isEmpty() => _entityList.isEmpty();

  add(T entity) {
    _entityList.add(entity);
    if (entity.code != null) {
      if (_entityMap.containsKey(entity.code)) {
        if (_entityMap[entity.code] != null) {
          throw new IllegalArgumentException('Entity code must be unique.');
        }
      }
      _entityMap[entity.code] = entity;
    }
    if (sourceEntities != null && propagateToSource) {
      sourceEntities.add(entity);
    }
  }

  bool contains(T entity) {
    if (entity.code != null) {
      if(_entityMap.containsKey(entity.code)) {
        T element = _entityMap[entity.code];
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
    return false;
  }

  empty() {
    _entityList.clear();
    _entityMap.clear();
  }

  remove(T entity) {
    for (T element in _entityList) {
      if (element == entity) {
        int index = _entityList.indexOf(element, 0);
        _entityList.removeRange(index, 1);
        if (entity.code != null) {
          _entityMap.remove(entity.code);
        }
      }
    }
    if (sourceEntities != null && propagateToSource) {
      sourceEntities.remove(entity);
    }
  }

  List<T> filter(Function f) {
    return _entityList.filter(f);
  }

  addFrom(List<T> other) {
    other.forEach((entity) => add(entity));
  }

  /*
  Entities<T> filter(Function f) {
    List<T> filteredList = _entityList.filter(f);
    // need to use reflection to create specific entities based on the concept
    Entities<T> selectedEntities = new Entities.of(_concept);
    filteredList.forEach((entity) => selectedEntities.add(entity));
    selectedEntities._sourceEntities = this;
    return selectedEntities;
  }
  */

  List<T> getList() => new List.from(_entityList);

  T getEntity(String code) {
    if (_entityMap.containsKey(code)) {
      return _entityMap[code];
    } else {
      for (T element in _entityList) {
        if (element.code == code) {
         return element;
        }
      }
      return null;
    }
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
