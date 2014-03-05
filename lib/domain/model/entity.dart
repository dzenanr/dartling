part of dartling;

abstract class EntityApi<E extends EntityApi<E>> implements Comparable {

  Concept get concept;
  ValidationErrorsApi get errors;
  Oid get oid;
  IdApi get id;
  String code;

  Object getAttribute(String name);
  bool preSetAttribute(String name, Object value);
  bool setAttribute(String name, Object value);
  bool postSetAttribute(String name, Object value);
  String getStringFromAttribute(String name);
  bool setStringToAttribute(String name, String string);
  EntityApi getParent(String name);
  bool setParent(String name, EntityApi entity);
  EntitiesApi getChild(String name);
  bool setChild(String name, EntitiesApi entities);

  E copy();
  Map<String, Object> toJson();

}

class ConceptEntity<E extends ConceptEntity<E>> implements EntityApi {

  Concept _concept;
  ValidationErrors _errors;
  Oid _oid;
  String _code;

  Map<String, Object> _attributeMap;
  // cannot use T since a parent is of a different type
  Map<String, ConceptEntity> _parentMap;
  Map<String, Entities> _childMap;
  Map<String, Entities> _internalChildMap;

  bool pre = true;
  bool post = true;

  ConceptEntity() {
    _errors = new ValidationErrors();
    _oid = new Oid();

    pre = false;
    post = false;
  }

  ConceptEntity.of(this._concept) {
    _errors = new ValidationErrors();
    _oid = new Oid();
    _attributeMap = new Map<String, Object>();
    _parentMap = new Map<String, ConceptEntity>();
    _childMap = new Map<String, Entities>();
    _internalChildMap = new Map<String, Entities>();

    for (Attribute a in _concept.attributes) {
      if (a.init == null) {
        _attributeMap[a.code] = null;
      } else if (a.type.base == 'DateTime' && a.init == 'now') {
          _attributeMap[a.code] = new DateTime.now();
      } else if (a.type.base == 'bool' && a.init == 'true') {
          _attributeMap[a.code] = true;
      } else if (a.type.base == 'bool' && a.init == 'false') {
          _attributeMap[a.code] = false;
      } else if (a.type.base == 'int') {
        try {
          _attributeMap[a.code] = int.parse(a.init);
        } on FormatException catch (e) {
          throw new TypeError(
              '${a.code} attribute init (default) value is not int: $e');
        }
      } else if (a.type.base == 'double') {
        try {
          _attributeMap[a.code] = double.parse(a.init);
        } on FormatException catch (e) {
          throw new TypeError(
              '${a.code} attribute init (default) value is not double: $e');
        }
      } else if (a.type.base == 'num') {
        try {
          _attributeMap[a.code] = int.parse(a.init);
        } on FormatException catch (e1) {
          try {
            _attributeMap[a.code] = double.parse(a.init);
          } on FormatException catch (e2) {
            throw new TypeError(
                '${a.code} attribute init (default) value is not num: $e1; $e2');
          }
        }
      } else if (a.type.base == 'Uri') {
        try {
          _attributeMap[a.code] = Uri.parse(a.init);
        } on ArgumentError catch (e) {
          throw new TypeError(
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
      var childEntities = new Entities.of(child.destinationConcept);
      _childMap[child.code] = childEntities;
      if (child.internal) {
        _internalChildMap[child.code] = childEntities;
      }
    }
  }

  ConceptEntity<E> newEntity() => new ConceptEntity.of(_concept);
  Entities<E> newEntities() => new Entities.of(_concept);

  Concept get concept => _concept;
  ValidationErrors get errors => _errors;

  Oid get oid => _oid;
  void set oid(Oid oid) {
    if (_concept.updateOid) {
      _oid = oid;
    } else {
      throw new OidError('Entity oid cannot be updated.');
    }
  }

  String get code => _code;
  void set code(String code) {
    if (_code == null || _concept.updateCode) {
      _code = code;
    } else {
      throw new CodeError('Entity code cannot be updated.');
    }
  }

  Id get id {
    if (_concept == null) {
      throw new ConceptError('Entity concept is not defined.');
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
    if (id.length == 0) {
      return null;
    }
    return id;
  }

  String get codeFirstLetterLower => _firstLetterLowerCase();
  String get codeFirstLetterUpper => _firstLetterUpperCase();
  String get codeLowerUnderscore => _camelCaseLowerCaseUnderscore();

  String get codePlural => _plural();
  String get codePluralFirstLetterLower => _firstLetterLowerCase(plural:true);
  String get codePluralFirstLetterUpper => _firstLetterUpperCase(plural:true);
  String get codePluralLowerUnderscore =>
      _camelCaseLowerCaseUnderscore(plural:true);

  String _plural() {
    String dropEnd(String end) {
      String withoutEnd = _code;
      int endPosition = _code.lastIndexOf(end);
      if (endPosition > 0) {
        // Drop the end.
        withoutEnd = _code.substring(0, endPosition);
      }
      return withoutEnd;
    }

    if (_code != null) {
      var result;
      if (_code.length > 0) {
        String lastLetter = _code.substring(_code.length - 1, _code.length);
        if (lastLetter == 'x') {
          result = '${_code}es';
        } else if (lastLetter == 'z') {
          result = '${_code}zes';
        } else if (lastLetter == 'y') {
          String withoutLast = dropEnd(lastLetter);
          result = '${withoutLast}ies';
        } else {
          result = '${_code}s';
        }
      }
      return result;
    }
    return null;
  }

  String _firstLetterLowerCase({plural:false}) {
    var c = _code;
    if (plural) {
      c = codePlural;
    }
    if (c != null) {
      List<String> letterList = c.split('');
      letterList[0] = letterList[0].toLowerCase();
      String result = '';
      for (String letter in letterList) {
        result = '${result}${letter}';
      }
      return result;
    }
    return null;
  }

  String _firstLetterUpperCase({plural:false}) {
    var c = _code;
    if (plural) {
      c = codePlural;
    }
    if (c != null) {
      List<String> letterList = c.split('');
      letterList[0] = letterList[0].toUpperCase();
      String result = '';
      for (String letter in letterList) {
        result = '${result}${letter}';
      }
      return result;
    }
    return null;
  }

  String _camelCaseLowerCaseUnderscore({plural:false}) {
    var c = _code;
    if (plural) {
      c = codePlural;
    }
    if (c != null) {
      RegExp exp = new RegExp(r"([A-Z])");
      Iterable<Match> matches = exp.allMatches(c);
      var indexes = new List<int>();
      for (Match m in matches) {
        indexes.add(m.end);
      };
      int previousIndex = 0;
      var camelCaseWordList = new List<String>();
      for (int index in indexes) {
        String camelCaseWord = c.substring(previousIndex, index - 1);
        camelCaseWordList.add(camelCaseWord);
        previousIndex = index - 1;
      }
      String camelCaseWord = c.substring(previousIndex);
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
    return null;
  }

  bool preSetAttribute(String name, Object value) {
    if (!pre) {
      return true;
    }

    if (_concept == null) {
      throw new ConceptError(
        'Entity(oid: ${oid}) concept is not defined.');
    }
    return true;
  }

  Object getAttribute(String name) => _attributeMap[name];
  bool setAttribute(String name, Object value) {
    bool updated = false;
    if (preSetAttribute(name, value)) {
      if (_concept == null) {
        throw new ConceptError('Entity concept is not defined.');
      }
      Attribute attribute = _concept.attributes.singleWhereCode(name);
      if (attribute == null) {
        String msg = '${_concept.code}.$name is not correct attribute name.';
        throw new UpdateError(msg);
      }
      /*
       * validation done in Entities.preAdd
      if (value == null && attribute.minc != '0') {
        String msg = '${_concept.code}.$name cannot be null.';
        throw new UpdateException(msg);
      }
      */
      Object beforeValue = _attributeMap[name];
      if (getAttribute(name) == null) {
        _attributeMap[name] = value;
        updated = true;
      //} else if (!attribute.derive && attribute.update) {
      } else if (attribute.update) {
        _attributeMap[name] = value;
        updated = true;
      } else {
        String msg = '${_concept.code}.${attribute.code} is not updateable.';
        throw new UpdateError(msg);
        /*
        EntityError error = new EntityError('read-only');
        error.message = '${_concept.code}.${attribute.code} is not updateable.';
        _errors.add(error);
        */
      }
      if (postSetAttribute(name, value)) {
        updated = true;
      } else {
        var beforePre = pre;
        var beforePost = post;
        pre = false;
        post = false;
        if (!setAttribute(name, beforeValue)) {
          var msg = '${_concept.code}.${attribute.code} '
            'was set to a new value, post was not successful, '
            'set to the before value was not successful';
          throw new RemoveError(msg);
        }
        pre = beforePre;
        post = beforePost;
      }
    }
    return updated;
  }

  bool postSetAttribute(String name, Object value) {
    if (!post) {
      return true;
    }

    if (_concept == null) {
      throw new ConceptError(
        'Entity(oid: ${oid}) concept is not defined.');
    }
    return true;
  }

  String getStringFromAttribute(String name) => _attributeMap[name].toString();
  bool setStringToAttribute(String name, String string) {
    if (_concept == null) {
      throw new ConceptError('Entity concept is not defined.');
    }
    Attribute attribute = _concept.attributes.singleWhereCode(name);
    if (attribute == null) {
      String msg = '${_concept.code}.$name is not correct attribute name.';
      throw new UpdateError(msg);
    }

    if (string == null  || string == 'null') {
      return setAttribute(name, null);
    }
    if (attribute.type.base == 'DateTime') {
      try {
        assert(string != null);
        return setAttribute(name, DateTime.parse(string));
      } on ArgumentError catch (e) {
        throw new TypeError('${_concept.code}.${attribute.code} '
                                'attribute value is not DateTime: $e');
      }
    } else if (attribute.type.base == 'bool') {
      if (string == 'true') {
        return setAttribute(name, true);
      } else if (string == 'false') {
        return setAttribute(name, false);
      } else {
        throw new TypeError('${attribute.code} '
                                'attribute value is not bool.');
      }
    } else if (attribute.type.base == 'int') {
      try {
        return setAttribute(name, int.parse(string));
      } on FormatException catch (e) {
        throw new TypeError('${attribute.code} '
                                'attribute value is not int: $e');
      }
    } else if (attribute.type.base == 'double') {
      try {
        return setAttribute(name, double.parse(string));
      } on FormatException catch (e) {
        throw new TypeError('${attribute.code} '
                                'attribute value is not double: $e');
      }
    } else if (attribute.type.base == 'num') {
      try {
        return setAttribute(name, int.parse(string));
      } on FormatException catch (e1) {
        try {
          return setAttribute(name, double.parse(string));
        } on FormatException catch (e2) {
          throw new TypeError(
            '${attribute.code} attribute value is not num: $e1; $e2');
        }
      }
    } else if (attribute.type.base == 'Uri') {
      try {
        return setAttribute(name, Uri.parse(string));
      } on ArgumentError catch (e) {
        throw new TypeError('${attribute.code} '
                                'attribute value is not Uri: $e');
      }
    } else { // other
      return setAttribute(name, string);
    }
  }

  ConceptEntity getParent(String name) => _parentMap[name];
  bool setParent(String name, ConceptEntity entity) {
    if (_concept == null) {
      throw new ConceptError('Entity concept is not defined.');
    }
    Parent parent = _concept.parents.singleWhereCode(name);
    if (parent == null) {
      String msg = '${_concept.code}.$name is not correct parent entity name.';
      throw new UpdateError(msg);
    }

    if (getParent(name) == null) {
      _parentMap[name] = entity;
      return true;
    } else if (parent.update) {
      _parentMap[name] = entity;
      return true;
    } else {
      String msg = '${_concept.code}.${parent.code} is not updateable.';
      throw new UpdateError(msg);
    }
  }

  Entities getInternalChild(String name) => _internalChildMap[name];
  Entities getChild(String name) => _childMap[name];
  bool setChild(String name, Entities entities) {
    if (_concept == null) {
      throw new ConceptError('Entity concept is not defined.');
    }
    Child child = _concept.children.singleWhereCode(name);
    if (child == null) {
      String msg = '${_concept.code}.$name is not correct child entities name.';
      throw new UpdateError(msg);
    }
    if (child.update) {
      _childMap[name] = entities;
      if (child.internal) {
        _internalChildMap[name] = entities;
      }
      return true;
    } else {
      String msg = '${_concept.code}.${child.code} is not updateable.';
      throw new UpdateError(msg);
    }
  }

  /**
   * Copies the entity (oid, code, attributes and neighbors).
   * It is not a deep copy.
   */
  E copy() {
    if (_concept == null) {
      throw new ConceptError('Entity concept is not defined.');
    }
    E entity = newEntity();
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

  int get hashCode => _oid.hashCode;

  /**
  * Two entities are equal if their oids are equal.
  */
  bool equals(E entity) {
    if (_oid.equals(entity.oid)) {
      return true;
    }
    return false;
  }
  
  /**
   * == see:
   * https://www.dartlang.org/docs/dart-up-and-running/contents/ch02.html#op-equality
   *
   * To test whether two objects x and y represent the same thing,
   * use the == operator.
   *
   * (In the rare case where you need to know
   * whether two objects are the exact same object, use the identical()
   * function instead.)
   *
   * Here is how the == operator works:
   *
   * If x or y is null, return true if both are null,
   * and false if only one is null.
   *
   * Return the result of the method invocation x.==(y).
   *
   * Evolution:
   *
   * If x===y, return true.
   * Otherwise, if either x or y is null, return false.
   * Otherwise, return the result of x.equals(y).
   *
   * The newer spec is:
   * a) if either x or y is null, do identical(x, y)
   * b) otherwise call operator ==
   */
  bool operator ==(Object other) {
    if (other is ConceptEntity) {
      ConceptEntity entity = other;
      if (identical(this, entity)) {
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

  /*
  bool operator ==(Object other) {
    if (other is ConceptEntity) {
      ConceptEntity entity = other;
      if (this == null && entity == null) {
        return true;
      } else if (this == null || entity == null) {
        return false;
      } else if (identical(this, entity)) {
        return true;
      } else {
        return equals(entity);
      }
    } else {
      return false;
    }
  }
  */

  /**
   * Checks if the entity is equal in content to the given entity.
   * Two entities are equal if they have the same content, ignoring oid.
   */
   bool equalContent(E entity) {
     if (_concept == null) {
       throw new ConceptError('Entity concept is not defined.');
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
  int compareTo(E entity) {
    if (code != null) {
      return _code.compareTo(entity.code);
    } else {
      if (id == null || entity.id == null) {
        if (_concept == null) {
          throw new ConceptError('Entity concept is not defined.');
        }
        String msg =
            '${_concept.code} concept does not have an id.';
        throw new IdError(msg);
      }
      return id.compareTo(entity.id);
    }
  }

  /**
   * Returns a string that represents this entity by using oid and code.
   */
  String toString() {
    if (_concept != null) {
      if (_code == null) {
        return '{${_concept.code}: {oid:${_oid.toString()}}}';
      } else {
        return '{${_concept.code}: {oid:${_oid.toString()}, code:${_code}}}';
      }
    }
    return null;
  }

  void displayToString() {
    print(toString());
  }

  /**
   * Displays (prints) an entity with its attributes, parents and children.
   */
  display({String prefix:'', bool withOid:true, 
    bool withChildren:true, bool withInternalChildren:true}) {
    if (_concept == null) {
      throw new ConceptError('Entity concept is not defined.');
    }
    var s = prefix;
    if (!_concept.entry || (_concept.entry && _concept.parents.length > 0)) {
      s = '$prefix  ';
    }
    print('${s}------------------------------------');
    print('${s}${toString()}                       ');
    print('${s}------------------------------------');
    s = '$s  ';
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
      if (withInternalChildren) {
        _internalChildMap.forEach((k,v) {
          print('${s}$k:');
          if (_concept.isChildSensitive(k)) {
            print('**********');
          } else {
            v.display(title:'${s}$k', prefix:'${s}  ', withOid:withOid, 
              withChildren:withChildren, withInternalChildren:withInternalChildren);
          }
        });
      } else {
        _childMap.forEach((k,v) {
          print('${s}$k:');
          if (_concept.isChildSensitive(k)) {
            print('**********');
          } else {
            v.display(title:'${s}$k', prefix:'${s}  ', withOid:withOid, 
              withChildren:withChildren, withInternalChildren:withInternalChildren);
          }
        });
      }
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
    entityMap['code'] = _code;
    _attributeMap.keys.forEach((k) =>
        entityMap[k] = getStringFromAttribute(k));
    _internalChildMap.keys.forEach(
        (k) => entityMap[k] = getInternalChild(k).toJson());
    return entityMap;
  }

  /**
   * Loads attribute values without validations to this.
   * It does not handle neighbors.
   * See ModelEntries for the JSON transfer at the level of a model entry.
   */
  fromJson(Map<String, Object> entityMap) {
    int timeStamp;
    try {
      timeStamp = int.parse(entityMap['oid']);
    } on FormatException catch (e) {
      throw new TypeError('${entityMap['oid']} oid is not int: $e');
    }

    var beforeUpdateOid = concept.updateOid;
    concept.updateOid = true;
    oid = new Oid.ts(timeStamp);
    concept.updateOid = beforeUpdateOid;

    var beforeUpdateCode = concept.updateCode;
    concept.updateCode = true;
    code = entityMap['code'];
    concept.updateCode = beforeUpdateCode;

    pre = false;
    for (Attribute attribute in concept.attributes) {
      if (attribute.identifier) {
        var beforUpdate = attribute.update;
        attribute.update = true;
        setStringToAttribute(attribute.code, entityMap[attribute.code]);
        attribute.update = beforUpdate;
      } else {
        setStringToAttribute(attribute.code, entityMap[attribute.code]);
      }
    }
    pre = true;
  }

}
