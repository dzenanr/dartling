
class Entity<T extends Entity<T>> implements Comparable {

  Oid _oid;
  String _code;

  Concept _concept;

  Map<String, Object> _attributeMap;
  // cannot use T since a parent is of a different type
  Map<String, Entity> _parentMap;
  Map<String, Entities> _childMap;

  List<Reaction> _reactions;
  History history;

  Entity() {
    _oid = new Oid();
    _reactions = new List<Reaction>();
    history = new History();
  }

  Entity.of(this._concept) {
    _oid = new Oid();
    _attributeMap = new Map<String, Object>();
    _parentMap = new Map<String, Entity>();
    _childMap = new Map<String, Entities>();
    _reactions = new List<Reaction>();
    history = new History();

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

  String getStringFromAttribute(String name) => _attributeMap[name].toString();
  setStringToAttribute(String name, String string) {
    if (string == null) {
      throw new IllegalArgumentException(
        'Entity.setStringToAttribute argument is null.');
    }
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Attribute a = _concept.attributes.getEntityByCode(name);
    if (a.type.base == 'Date') {
      try {
        setAttribute(name, new Date.fromString(string));
      } catch (final IllegalArgumentException e) {
        throw new TypeException('${a.code} attribute value is not Date: $e');
      }
    } else if (a.type.base == 'bool') {
      if (string == 'true') {
        setAttribute(name, true);
      } else if (string == 'false') {
        setAttribute(name, false);
      } else {
        throw new TypeException('${a.code} attribute value is not bool.');
      }
    } else if (a.type.base == 'int') {
      try {
        setAttribute(name, Math.parseInt(string));
      } catch (final BadNumberFormatException e) {
        throw new TypeException('${a.code} attribute value is not int: $e');
      }
    } else if (a.type.base == 'double') {
      try {
        setAttribute(name, Math.parseDouble(string));
      } catch (final BadNumberFormatException e) {
        throw new TypeException('${a.code} attribute value is not double: $e');
      }
    } else if (a.type.base == 'num') {
      try {
        setAttribute(name, Math.parseInt(string));
      } catch (final BadNumberFormatException e1) {
        try {
          setAttribute(name, Math.parseDouble(string));
        } catch (final BadNumberFormatException e2) {
          throw new TypeException(
            '${a.code} attribute value is not num: $e1; $e2');
        }
      }
    } else if (a.type.base == 'Uri') {
      try {
        setAttribute(name, new Uri.fromString(string));
      } catch (final IllegalArgumentException e) {
        throw new TypeException('${a.code} attribute value is not Uri: $e');
      }
    } else {
      setAttribute(name, string);
    }
  }

  Object getAttribute(String name) => _attributeMap[name];
  setAttribute(String name, Object value) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Attribute attribute = _concept.attributes.getEntityByCode(name);
    if (!attribute.derive && attribute.update) {
      var action = new EntityAction('set');
      action.category = 'attribute';
      action.entity = this;
      action.property = name;
      action.before = getAttribute(name);
      action.description = 'Entity.setAttribute $name with $value value.';

      _attributeMap[name] = value;

      action.after = value;
      history.add(action);
      notifyReactions(action);
      return true;
    } else {
      String msg = '${_concept.code}.${attribute.code} is not updateable.';
      throw new UpdateException(msg);
    }
    return false;
  }

  Entity getParent(String name) => _parentMap[name];
  setParent(String name, Entity entity) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Parent parent = _concept.parents.getEntityByCode(name);
    if (parent.update) {
      var action = new EntityAction('set');
      action.category = 'parent';
      action.entity = this;
      action.property = name;
      action.before = getParent(name);
      action.description = 'Entity.setParent $name with $entity entity.';

      _parentMap[name] = entity;

      action.after = entity;
      history.add(action);
      notifyReactions(action);
      return true;
    } else {
      String msg = '${_concept.code}.${parent.code} is not updateable.';
      throw new UpdateException(msg);
    }
    return false;
  }

  Entities getChild(String name) => _childMap[name];
  setChild(String name, Entities entities) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Child child = _concept.children.getEntityByCode(name);
    if (child.update) {
      var action = new EntityAction('set');
      action.category = 'child';
      action.entity = this;
      action.property = name;
      action.before = getChild(name);
      action.description =
          'Entity.setChild $name with ${entities.count} entities.';

      _childMap[name] = entities;

      action.after = entities;
      history.add(action);
      notifyReactions(action);
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

  start(Reaction reaction) => _reactions.add(reaction);
  cancel(Reaction reaction) {
    int index = _reactions.indexOf(reaction, 0);
    _reactions.removeRange(index, 1);
  }

  notifyReactions(Action action) {
    for (Reaction reaction in _reactions) {
      reaction.react(action);
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
