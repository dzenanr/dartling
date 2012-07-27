
class Entity<T extends Entity<T>> implements Comparable {

  Oid _oid;
  String _code;

  Concept _concept;

  Map<String, Object> _attributeMap;
  Map<String, Entity> _parentMap;
  Map<String, Entities> _childMap;

  Entity() {
    _oid = new Oid();
  }

  Entity.of(this._concept) {
    _oid = new Oid();
    _attributeMap = new Map<String, Object>();
    _parentMap = new Map<String, Entity>();
    _childMap = new Map<String, Entities>();

    for (Attribute a in _concept.attributes) {
      if (a.init != null) {
        _attributeMap[a.code] = a.init;
      } else if (a.increment != null) {
        _attributeMap[a.code] = a.increment;
      } else {
        _attributeMap[a.code] = null;
      }
    }

    for (Parent parent in _concept.parents) {
      _parentMap[parent.code] = null;
    }

    for (Child child in _concept.children) {
      var entities = new Entities();
      entities._concept = child.destinationConcept;
      _childMap[child.code] = entities;
    }
  }

  Oid get oid() => _oid;

  String get code() => _code;
  set code(String code) {
    if (_code != null) {
      throw new CodeException('Entity code cannot be updated.');
    }
    if (code == null) {
      throw new CodeException('Entity code cannot be nullified.');
    }
    _code = code;
  }

  Concept get concept() => _concept;

  Object getAttribute(String name) => _attributeMap[name];
  setAttribute(String name, Object value) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Attribute attribute = _concept.attributes.getEntityByCode(name);
    if (!attribute.derive && attribute.update) {
      _attributeMap[name] = value;
    } else {
      String msg = '${_concept.code}.${attribute.code} is not updateable.';
      throw new UpdateException(msg);
    }
  }

  Entity getParent(String name) => _parentMap[name];
  setParent(String name, Entity entity) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Parent parent = _concept.parents.getEntityByCode(name);
    if (parent.update) {
      _parentMap[name] = entity;
    } else {
      String msg = '${_concept.code}.${parent.code} is not updateable.';
      throw new UpdateException(msg);
    }
  }

  Entities getChild(String name) => _childMap[name];
  setChild(String name, Entities entities) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Child child = _concept.children.getEntityByCode(name);
    if (child.update) {
      _childMap[name] = entities;
    } else {
      String msg = '${_concept.code}.${child.code} is not updateable.';
      throw new UpdateException(msg);
    }
  }

  Id get id() {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Id id = new Id(_concept);
    for (Parent p in _concept.parents) {
      if (p.id) {
        id.setParent(p.code, _parentMap[p.code]);
      }
    }
    for (Attribute a in _concept.attributes) {
      if (a.id) {
        id.setAttribute(a.code, _attributeMap[a.code]);
      }
    }
    if (id.count == 0) {
      return null;
    }
    return id;
  }

  /**
   * Copies the entity (oid, code, attributes and neighbors).
   */
  T copy() {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    T e = new Entity.of(_concept);
    e._oid = _oid;
    e.code = _code;
    for (Attribute a in _concept.attributes) {
      e.setAttribute(a.code, _attributeMap[a.code]);
    }

    for (Parent parent in _concept.parents) {
      e.setParent(parent.code, _parentMap[parent.code]);
    }

    for (Child child in _concept.children) {
      e.setChild(child.code, _childMap[child.code]);
    }

    return e;
  }

  /**
  * Checks if the entity is equal to the given object.
  * If the given object is not of the T type,
  * two objects cannot be equal.
  * Two entities are equal if their oids are equal.
  */
  bool equalOids(other) {
    if (other is T) {
      if (_oid != other.oid) {
        return false;
      }
    } else {
      return false;
    }
    return true;
  }

  /**
   * Checks if the entity is equal in content to the given object.
   * If the given object is not of the T type,
   * two objects cannot be equal. Two entities are
   * equal if they have the same content, except oid.
   */
   bool equals(other) {
     if (_concept == null) {
       throw new ConceptException('Entity concept is not defined.');
     }
     if (other is T) {
       if (_code != other.code) {
         return false;
       }
       for (Attribute a in _concept.attributes) {
         if (_attributeMap[a.code] != other.getAttribute(a.code)) {
           return false;
         }
       }

       for (Parent parent in _concept.parents) {
         if (_parentMap[parent.code] != other.getParent(parent.code)) {
           return false;
         }
       }

       for (Child child in _concept.children) {
         if (_childMap[child.code] != other.getChild(child.code)) {
           return false;
         }
       }
     } else {
       return false;
     }
     return true;
   }

  /**
   * Compares two entities based on codes.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(T entity) {
    if (code != null) {
      return _code.compareTo(entity.code);
    }
    throw new CodeException('Entity code is not used.');
  }

  /**
   * Returns a string that represents this entity by using oid and code.
   */
  String toString() {
    if (_code == null) {
      return '${_oid.toString()}';
    }
    return '${_oid.toString()} $_code';
  }

  /**
   * Displays (prints) an entity with its attributes, parents and children.
   */
  display([String space='', bool withOid=true]) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    var s = space;
    if (!_concept.entry) {
      s = '$space  ';
    }
    print('${s}------------------------------------');
    print('${s}${toString()}                       ');
    print('${s}------------------------------------');
    if (withOid) {
      print('${s}oid: $_oid');
    }
    if (_code != null) {
      print('${s}code: $_code');
    }

    _attributeMap.forEach((k,v) {
      print('${s}$k: $v');
    });

    _parentMap.forEach((k,v) {
      print('${s}$k: ${v.toString()}');
    });

    _childMap.forEach((k,v) {
      print('${s}$k:');
      v.display(s, withOid);
    });

    print('');
  }

}
