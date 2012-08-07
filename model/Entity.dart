
abstract class AEntity<T extends Entity<T>> implements Comparable {

  abstract Entity<T> newEntity();
  abstract Concept get concept();
  abstract Oid get oid();
  abstract String get code();
  abstract void set code(String code);
  abstract Object getAttribute(String name);
  abstract bool setAttribute(String name, Object value);
  abstract String getStringFromAttribute(String name);
  abstract bool setStringToAttribute(String name, String string);
  abstract Entity getParent(String name);
  abstract bool setParent(String name, Entity entity);
  abstract Entities getChild(String name);
  abstract bool setChild(String name, Entities entities);

  abstract Id get id();
  abstract T copy();
  abstract bool equalOids(T entity);
  abstract bool equals(other);
  abstract int compareTo(T entity);
  abstract String toString();

}

class Entity<T extends Entity<T>> implements AEntity {

  Concept _concept;
  Oid _oid;
  String _code;
  Map<String, Object> _attributeMap;
  // cannot use T since a parent is of a different type
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
        if (a.type.base == 'Date' && a.init == 'now') {
          _attributeMap[a.code] = new Date.now();
        } else if (a.type.base == 'bool' && a.init == 'true') {
          _attributeMap[a.code] = true;
        } else if (a.type.base == 'bool' && a.init == 'false') {
          _attributeMap[a.code] = false;
        } else if (a.type.base == 'int') {
          try {
            _attributeMap[a.code] = Math.parseInt(a.init);
          } catch (final BadNumberFormatException e) {
            throw new TypeException(
              '${a.code} attribute init (default) value is not int: $e');
          }
        } else if (a.type.base == 'double') {
          try {
            _attributeMap[a.code] = Math.parseDouble(a.init);
          } catch (final BadNumberFormatException e) {
            throw new TypeException(
              '${a.code} attribute init (default) value is not double: $e');
          }
        } else if (a.type.base == 'num') {
          try {
            _attributeMap[a.code] = Math.parseInt(a.init);
          } catch (final BadNumberFormatException e1) {
            try {
              _attributeMap[a.code] = Math.parseDouble(a.init);
            } catch (final BadNumberFormatException e2) {
              throw new TypeException(
                '${a.code} attribute init (default) value is not num: $e1; $e2');
            }
          }
        } else if (a.type.base == 'Uri') {
          try {
            _attributeMap[a.code] = new Uri.fromString(a.init);
          } catch (final IllegalArgumentException e) {
            throw new TypeException(
              '${a.code} attribute init (default) value is not Uri: $e');
          }
        } else {
          _attributeMap[a.code] = a.init;
        }
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

  Entity<T> newEntity() => new Entity.of(_concept);

  Concept get concept() => _concept;
  Oid get oid() => _oid;
  String get code() => _code;
  void set code(String code) {
    if (_code != null) {
      throw new CodeException('Entity code cannot be updated.');
    }
    if (code == null) {
      throw new CodeException('Entity code cannot be nullified.');
    }
    _code = code;
  }

  Object getAttribute(String name) => _attributeMap[name];
  bool setAttribute(String name, Object value) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Attribute attribute = _concept.attributes.findByCode(name);
    if (attribute == null) {
      String msg = '${_concept.code}.$name is not correct attribute name.';
      throw new UpdateException(msg);
    }
    if (!attribute.derive && attribute.update) {
      _attributeMap[name] = value;
      return true;
    } else {
      String msg = '${_concept.code}.${attribute.code} is not updateable.';
      throw new UpdateException(msg);
    }
    return false;
  }

  String getStringFromAttribute(String name) => _attributeMap[name].toString();
  bool setStringToAttribute(String name, String string) {
    if (string == null) {
      throw new IllegalArgumentException(
        'Entity.setStringToAttribute argument is null.');
    }
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Attribute attribute = _concept.attributes.findByCode(name);
    if (attribute == null) {
      String msg = '${_concept.code}.$name is not correct attribute name.';
      throw new UpdateException(msg);
    }
    if (attribute.type.base == 'Date') {
      try {
        return setAttribute(name, new Date.fromString(string));
      } catch (final IllegalArgumentException e) {
        throw new TypeException('${attribute.code} attribute value is not Date: $e');
      }
    } else if (attribute.type.base == 'bool') {
      if (string == 'true') {
        return setAttribute(name, true);
      } else if (string == 'false') {
        return setAttribute(name, false);
      } else {
        throw new TypeException('${attribute.code} attribute value is not bool.');
      }
    } else if (attribute.type.base == 'int') {
      try {
        return setAttribute(name, Math.parseInt(string));
      } catch (final BadNumberFormatException e) {
        throw new TypeException('${attribute.code} attribute value is not int: $e');
      }
    } else if (attribute.type.base == 'double') {
      try {
        return setAttribute(name, Math.parseDouble(string));
      } catch (final BadNumberFormatException e) {
        throw new TypeException('${attribute.code} attribute value is not double: $e');
      }
    } else if (attribute.type.base == 'num') {
      try {
        return setAttribute(name, Math.parseInt(string));
      } catch (final BadNumberFormatException e1) {
        try {
          return setAttribute(name, Math.parseDouble(string));
        } catch (final BadNumberFormatException e2) {
          throw new TypeException(
            '${attribute.code} attribute value is not num: $e1; $e2');
        }
      }
    } else if (attribute.type.base == 'Uri') {
      try {
        return setAttribute(name, new Uri.fromString(string));
      } catch (final IllegalArgumentException e) {
        throw new TypeException('${attribute.code} attribute value is not Uri: $e');
      }
    } else { // other
      return setAttribute(name, string);
    }
  }

  Entity getParent(String name) => _parentMap[name];
  bool setParent(String name, Entity entity) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Parent parent = _concept.parents.findByCode(name);
    if (parent == null) {
      String msg = '${_concept.code}.$name is not correct parent entity name.';
      throw new UpdateException(msg);
    }
    if (parent.update) {
      _parentMap[name] = entity;
      return true;
    } else {
      String msg = '${_concept.code}.${parent.code} is not updateable.';
      throw new UpdateException(msg);
    }
    return false;
  }

  Entities getChild(String name) => _childMap[name];
  bool setChild(String name, Entities entities) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Child child = _concept.children.findByCode(name);
    if (child == null) {
      String msg = '${_concept.code}.$name is not correct child entities name.';
      throw new UpdateException(msg);
    }
    if (child.update) {
      _childMap[name] = entities;
      return true;
    } else {
      String msg = '${_concept.code}.${child.code} is not updateable.';
      throw new UpdateException(msg);
    }
    return false;
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
   * It is not a deep copy.
   */
  T copy() {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    T e = newEntity();
    e._oid = _oid;
    if (_code != null) {
      e.code = _code;
    }
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
  * Two entities are equal if their oids are equal.
  */
  bool equalOids(T entity) {
    if (_oid != entity.oid) {
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
       var entity = other;
       if (_code != entity.code) {
         return false;
       }
       for (Attribute a in _concept.attributes) {
         if (_attributeMap[a.code] != entity.getAttribute(a.code)) {
           return false;
         }
       }

       for (Parent parent in _concept.parents) {
         if (_parentMap[parent.code] != entity.getParent(parent.code)) {
           return false;
         }
       }

       for (Child child in _concept.children) {
         if (_childMap[child.code] != entity.getChild(child.code)) {
           return false;
         }
       }
     } else {
       return false;
     }
     return true;
   }

  /**
   * Compares two entities based on codes or ids.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(T entity) {
    if (code != null) {
      return _code.compareTo(entity.code);
    } else {
      if (id == null || entity.id == null) {
        if (_concept == null) {
          throw new ConceptException('Entity concept is not defined.');
        }
        String msg =
            '${_concept.code} concept does not have an id.';
        throw new IdException(msg);
      }
      return id.compareTo(entity.id);
    }
  }

  /**
   * Returns a string that represents this entity by using oid and code.
   */
  String toString() {
    return '${_oid.toString()}';
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
    if (id != null) {
      print('${s}id: $id');
    }

    _attributeMap.forEach((k,v) {
      if (_concept.isAttributeSensitive(k)) {
        print('${s}$k: **********');
      } else {
        print('${s}$k: $v');
      }
    });

    _parentMap.forEach((k,v) {
      if (_concept.isParentSensitive(k)) {
        print('${s}$k: **********');
      } else {
        print('${s}$k: ${v.toString()}');
      }
    });

    _childMap.forEach((k,v) {
      print('${s}$k:');
      if (_concept.isChildSensitive(k)) {
        print('**********');
      } else {
        v.display(s, withOid);
      }
    });

    print('');
  }

}
