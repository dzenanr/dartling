
abstract class EntityApi<T extends EntityApi<T>> implements Comparable {

  abstract Concept get concept();
  abstract String get code();
  abstract void set code(String code);

  abstract Object getAttribute(String name);
  abstract bool setAttribute(String name, Object value);
  abstract String getStringFromAttribute(String name);
  abstract bool setStringToAttribute(String name, String string);
  abstract EntityApi getParent(String name);
  abstract bool setParent(String name, EntityApi entity);
  abstract EntitiesApi getChild(String name);
  abstract bool setChild(String name, EntitiesApi entities);

  abstract IdApi get id();
  abstract T copy();
  abstract Map<String, Object> toJson();

}

class ConceptEntity<T extends ConceptEntity<T>> implements EntityApi {

  Concept _concept;
  Oid _oid;
  String _code;
  String _codeWithFirstLetterInLowerCase;
  String _codeWithCamelCaseInLowerCaseUnderscore;

  Map<String, Object> _attributeMap;
  // cannot use T since a parent is of a different type
  Map<String, ConceptEntity> _parentMap;
  Map<String, Entities> _childMap;

  ConceptEntity() {
    _oid = new Oid();
  }

  ConceptEntity.of(this._concept) {
    _oid = new Oid();
    _attributeMap = new Map<String, Object>();
    _parentMap = new Map<String, ConceptEntity>();
    _childMap = new Map<String, Entities>();

    for (Attribute a in _concept.attributes) {
      if (a.init == null) {
        _attributeMap[a.code] = null;
      } else if (a.type.base == 'Date' && a.init == 'now') {
          _attributeMap[a.code] = new Date.now();
      } else if (a.type.base == 'bool' && a.init == 'true') {
          _attributeMap[a.code] = true;
      } else if (a.type.base == 'bool' && a.init == 'false') {
          _attributeMap[a.code] = false;
      } else if (a.type.base == 'int') {
        try {
          _attributeMap[a.code] = Math.parseInt(a.init);
        } catch (final FormatException e) {
          throw new TypeException(
              '${a.code} attribute init (default) value is not int: $e');
        }
      } else if (a.type.base == 'double') {
        try {
          _attributeMap[a.code] = Math.parseDouble(a.init);
        } catch (final FormatException e) {
          throw new TypeException(
              '${a.code} attribute init (default) value is not double: $e');
        }
      } else if (a.type.base == 'num') {
        try {
          _attributeMap[a.code] = Math.parseInt(a.init);
        } catch (final FormatException e1) {
          try {
            _attributeMap[a.code] = Math.parseDouble(a.init);
          } catch (final FormatException e2) {
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
    } // for

    for (Parent parent in _concept.parents) {
      _parentMap[parent.code] = null;
    }

    for (Child child in _concept.children) {
      _childMap[child.code] = new Entities.of(child.destinationConcept);
    }
  }

  ConceptEntity<T> newEntity() => new ConceptEntity.of(_concept);

  Concept get concept() => _concept;

  Oid get oid() => _oid;
  void set oid(Oid oid) {
    if (_concept.updateOid) {
      _oid = oid;
    } else {
      throw new OidException('Entity oid cannot be updated.');
    }
  }

  String get code() => _code;
  void set code(String code) {
    if (_code == null || _concept.updateCode) {
      _code = code;
      if (code == null) {
        _codeWithFirstLetterInLowerCase = null;
        _codeWithCamelCaseInLowerCaseUnderscore = null;
      } else {
        _codeWithFirstLetterInLowerCase = firstLetterToLowerCase(code);
        _codeWithCamelCaseInLowerCaseUnderscore =
            camelCaseToLowerCaseUnderscore(code);
      }
    } else {
      throw new CodeException('Entity code cannot be updated.');
    }
  }

  String get codeWithFirstLetterInLowerCase() =>
      _codeWithFirstLetterInLowerCase;

  String get codeWithCamelCaseInLowerCaseUnderscore() =>
      _codeWithCamelCaseInLowerCaseUnderscore;



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
    /*
     * validation done in Entities.preAdd
    if (value == null && attribute.minc != '0') {
      String msg = '${_concept.code}.$name cannot be null.';
      throw new UpdateException(msg);
    }
    */
    if (getAttribute(name) == null) {
      _attributeMap[name] = value;
      return true;
    } else if (!attribute.derive && attribute.update) {
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
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Attribute attribute = _concept.attributes.findByCode(name);
    if (attribute == null) {
      String msg = '${_concept.code}.$name is not correct attribute name.';
      throw new UpdateException(msg);
    }

    if (string == null  || string == 'null') {
      return setAttribute(name, null);
    }
    if (attribute.type.base == 'Date') {
      try {
        assert(string != null);
        return setAttribute(name, new Date.fromString(string));
      } catch (final IllegalArgumentException e) {
        throw new TypeException('${_concept.code}.${attribute.code} attribute value is not Date: $e');
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
      } catch (final FormatException e) {
        throw new TypeException('${attribute.code} attribute value is not int: $e');
      }
    } else if (attribute.type.base == 'double') {
      try {
        return setAttribute(name, Math.parseDouble(string));
      } catch (final FormatException e) {
        throw new TypeException('${attribute.code} attribute value is not double: $e');
      }
    } else if (attribute.type.base == 'num') {
      try {
        return setAttribute(name, Math.parseInt(string));
      } catch (final FormatException e1) {
        try {
          return setAttribute(name, Math.parseDouble(string));
        } catch (final FormatException e2) {
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

  ConceptEntity getParent(String name) => _parentMap[name];
  bool setParent(String name, ConceptEntity entity) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    Parent parent = _concept.parents.findByCode(name);
    if (parent == null) {
      String msg = '${_concept.code}.$name is not correct parent entity name.';
      throw new UpdateException(msg);
    }

    if (getParent(name) == null) {
      _parentMap[name] = entity;
      return true;
    } else if (parent.identifier) {
      String msg = '${_concept.code}.${parent.code} is not updateable.';
      throw new UpdateException(msg);
    } else if (parent.update) {
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
      if (p.identifier) {
        id.setParent(p.code, _parentMap[p.code]);
      }
    }
    for (Attribute a in _concept.attributes) {
      if (a.identifier) {
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
    T entity = newEntity();
    assert(entity.concept != null);

    var beforeUpdateOid = entity.concept.updateOid;
    entity.concept.updateOid = true;
    entity.oid = _oid;
    entity.concept.updateOid = beforeUpdateOid;

    if (_code != null) {
      var beforeUpdateCode = entity.concept.updateCode;
      entity.concept.updateCode = true;
      entity.code = _code;
      entity.concept.updateCode = beforeUpdateCode;
    }

    for (Attribute attribute in _concept.attributes) {
      if (attribute.identifier) {
        var beforUpdate = attribute.update;
        attribute.update = true;
        entity.setAttribute(attribute.code, _attributeMap[attribute.code]);
        attribute.update = beforUpdate;
      } else {
        entity.setAttribute(attribute.code, _attributeMap[attribute.code]);
      }
    }

    for (Parent parent in _concept.parents) {
      if (parent.identifier) {
        var beforUpdate = parent.update;
        parent.update = true;
        entity.setParent(parent.code, _parentMap[parent.code]);
        parent.update = beforUpdate;
      } else {
        entity.setParent(parent.code, _parentMap[parent.code]);
      }
    }

    for (Child child in _concept.children) {
      entity.setChild(child.code, _childMap[child.code]);
    }

    return entity;
  }

  /**
  * Two entities are equal if their oids are equal.
  */
  bool equals(T entity) {
    if (_oid.equals(entity.oid)) {
      return true;
    }
    return false;
  }

  /**
   * ==
  *
   * If x===y, return true.
   * Otherwise, if either x or y is null, return false.
   * Otherwise, return the result of x.equals(y).
   *
   * The newest spec is:
   * a) if either x or y is null, do a ===
   * b) otherwise call operator ==
   */
  /*
  bool operator ==(Object other) {
    if (other is Entity) {
      Entity entity = other;
      if (this===entity) {
        return true;
      } else {
        if (this == null || entity == null) {
          return false;
        } else {
          return equals(entity);
        }
      }
    } else {
      return false;
    }
  }
  */
  bool operator ==(Object other) {
    if (other is ConceptEntity) {
      ConceptEntity entity = other;
      if (this == null || entity == null) {
        return this===entity;
      } else {
        return equals(entity);
      }
    } else {
      return false;
    }
  }

  /**
   * Checks if the entity is equal in content to the given entity.
   * Two entities are equal if they have the same content, ignoring oid.
   */
   bool equalContent(T entity) {
     if (_concept == null) {
       throw new ConceptException('Entity concept is not defined.');
     }
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

  String firstLetterToLowerCase(String text) {
    List<String> textList = text.splitChars();
    textList[0] = textList[0].toLowerCase();
    String result = '';
    for (String char in textList) {
      result = '${result}${char}';
    }
    return result;
  }

  String camelCaseToLowerCaseUnderscore(String text) {
    RegExp exp = const RegExp(@"([A-Z])");
    Iterable<Match> matches = exp.allMatches(text);
    var indexes = new List<int>();
    for (Match m in matches) {
      indexes.add(m.end());
    };
    int previousIndex = 0;
    var camelCaseWordList = new List<String>();
    for (int index in indexes) {
      String camelCaseWord = text.substring(previousIndex, index - 1);
      camelCaseWordList.add(camelCaseWord);
      previousIndex = index - 1;
    }
    String camelCaseWord = text.substring(previousIndex);
    camelCaseWordList.add(camelCaseWord);

    String previousCamelCaseWord;
    String result = '';
    for (String camelCaseWord in camelCaseWordList) {
      if (camelCaseWord == '') {
        previousCamelCaseWord = camelCaseWord;
      } else {
        if (previousCamelCaseWord == '') {
          result = '${result}${camelCaseWord}';
        } else {
          result = '${result}_${camelCaseWord}';
        }
        previousCamelCaseWord = camelCaseWord;
      }
    }
    return result.toLowerCase();
  }

  /**
   * Returns a string that represents this entity by using oid and code.
   */
  String toString() {
    if (code == null) {
      return '{${_concept.code}: {oid:${_oid.toString()}}}';
    } else {
      return '{${_concept.code}: {oid:${_oid.toString()}, code:${code}}}';
    }
  }

  void displayToString() {
    print(toString());
  }

  /**
   * Displays (prints) an entity with its attributes, parents and children.
   */
  display([String space='', bool withOid=true, bool withChildren=true]) {
    if (_concept == null) {
      throw new ConceptException('Entity concept is not defined.');
    }
    var s = space;
    if (!_concept.entry || (_concept.entry && _concept.parents.count > 0)) {
      s = '$space  ';
    }
    print('${s}------------------------------------');
    print('${s}${toString()}                       ');
    print('${s}------------------------------------');
    //if (_concept.entry && _concept.parents.count == 0) {
      s = '$s  ';
    //}
    if (withOid) {
      print('${s}oid: ${_oid}');
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

    if (withChildren) {
      _childMap.forEach((k,v) {
        print('${s}$k:');
        if (_concept.isChildSensitive(k)) {
          print('**********');
        } else {
          v.display('${s}$k', '${s}  ', withOid, withChildren);
        }
      });
    }

    print('');
  }

  Map<String, Object> toJson() {
    Map<String, Object> entityMap = new Map<String, Object>();
    for (Parent parent in _concept.parents) {
      ConceptEntity parentEntity = getParent(parent.code);
      if (parentEntity != null) {
        entityMap[parent.code] = parentEntity.oid.toString();
      } else {
        entityMap[parent.code] = 'null';
      }
    }
    entityMap['oid'] = _oid.toString();
    entityMap['code'] = code;
    _attributeMap.getKeys().forEach((k) =>
        entityMap[k] = getStringFromAttribute(k));
    _childMap.getKeys().forEach((k) => entityMap[k] = getChild(k).toJson());
    return entityMap;
  }

}
