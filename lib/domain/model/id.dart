part of dartling;

abstract class IdApi implements Comparable {

  Concept get concept;
  int get parentLength;  int get attributeLength;
  int get length;
  EntityApi getParent(String code);
  setParent(String code, EntityApi parent);

  Object getAttribute(String code);
  setAttribute(String code, Object attribute);

}

class Id implements IdApi {

  Concept _concept;

  Map<String, ConceptEntity> _parentMap;
  Map<String, Object> _attributeMap;

  Id(this._concept) {
    _parentMap = new Map<String, ConceptEntity>();
    _attributeMap = new Map<String, Object>();
    for (Parent p in _concept.parents) {
      if (p.identifier) {
        _parentMap[p.code] = null;
      }
    }
    for (Attribute a in concept.attributes) {
      if (a.identifier) {
        _attributeMap[a.code] = null;
      }
    }
  }

  Concept get concept => _concept;

  int get parentLength => _parentMap.length;
  int get attributeLength => _attributeMap.length;
  int get length => parentLength + attributeLength;

  ConceptEntity getParent(String code) => _parentMap[code];
  setParent(String code, ConceptEntity parent) => _parentMap[code] = parent;

  Object getAttribute(String code) => _attributeMap[code];
  setAttribute(String code, Object attribute) => _attributeMap[code] = attribute;
  
  int get hashCode => (_concept.hashCode + _parentMap.hashCode + _attributeMap.hashCode).hashCode;

  /** 
   * Two ids are equal if their parents are equal.
   */
   bool equalParents(Id id) {
     for (Parent p in _concept.parents) {
       if (p.identifier) {
         if (_parentMap[p.code] != id.getParent(p.code)) {
           return false;
         }
       }
     }
     return true;
   }


  /**
   * Two ids are equal if their attributes are equal.
   */
   bool equalAttributes(Id id) {
     for (Attribute a in concept.attributes) {
       if (a.identifier) {
         if (_attributeMap[a.code] != id.getAttribute(a.code)) {
           return false;
         }
       }
     }
     return true;
   }

  /**
   * Checks if the id is equal in content to the given id.
   * Two ids are equal if they have the same content.
   */
   bool equals(Id id) {
     if (_concept != id.concept) {
       return false;
     }
     if (!equalParents(id)) {
       return false;
     }
     if (!equalAttributes(id)) {
       return false;
     }
     return true;
   }

   /**
    * == see:
    * https://www.dartlang.org/docs/dart-up-and-running/contents/ch02.html#op-equality
    *
    * Evolution:
    *
    * If x===y, return true.
    * Otherwise, if either x or y is null, return false.
    * Otherwise, return the result of x.equals(y).
    *
    * a) if either x or y is null, do identical(x, y)
    * b) otherwise call operator ==
    */
   bool operator ==(Object other) {
     if (other is Id) {
       Id id = other;
       if (identical(this, id)) {
         return true;
       } else {
         if (this == null || id == null) {
           return false;
         } else {
           return equals(id);
         }
       }
     } else {
       return false;
     }
   }

  /*
   bool operator ==(Object other) {
     if (other is Id) {
       Id id = other;
       if (this == null && id == null) {
         return true;
       } else if (this == null || id == null) {
         return false;
       } else if (identical(this, id)) {
         return true;
       } else {
         return equals(id);
       }
     } else {
       return false;
     }
   }
   */

   /**
    * Compares two ids based on parents.
    * If the result is less than 0 then the first id is less than the second,
    * if it is equal to 0 they are equal and
    * if the result is greater than 0 then the first is greater than the second.
    */
   int compareParents(Id id) {
     if (id.parentLength > 0) {
       var compare = 0;
       for (Parent p in _concept.parents) {
         if (p.identifier) {
           compare = _parentMap[p.code].id.compareTo(id.getParent(p.code).id);
           if (compare != 0) {
             break;
           }
         }
       }
       return compare;
     }
     throw new IdError('${_concept.code}.id does not have parents.');
   }

   /**
    * Compares two ids based on attributes.
    * If the result is less than 0 then the first id is less than the second,
    * if it is equal to 0 they are equal and
    * if the result is greater than 0 then the first is greater than the second.
    */
   int compareAttributes(Id id) {
     if (id.attributeLength > 0) {
       var compare = 0;
       for (Attribute a in concept.attributes) {
         if (a.identifier) {
           if (a.type.base == 'String') {
             String attribute = _attributeMap[a.code];
             compare = attribute.compareTo(id.getAttribute(a.code));
           } else if (a.type.base == 'DateTime') {
             DateTime attribute = _attributeMap[a.code];
             compare = attribute.compareTo(id.getAttribute(a.code));
           } else if (a.type.base == 'num' ||
             a.type.code == 'int' || a.type.code == 'double') {
             num attribute = _attributeMap[a.code];
             compare = attribute.compareTo(id.getAttribute(a.code));
           } else {
             String msg =
             '${a.concept.code}.${a.code} is of ${a.type.code} type: cannot order.';
             throw new OrderError(msg);
           }
           if (compare != 0) {
             break;
           }
         } // if (a.id)
       } // for
       return compare;
     }
     throw new IdError('${_concept.code}.id does not have attributes.');
   }

   /**
   * Compares two ids based on parent entity ids and attributes.
   * If the result is less than 0 then the first id is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Id id) {
    if (id.length > 0) {
      var compare = 0;
      if (id.parentLength > 0) {
        compare = compareParents(id);
      }
      if (compare == 0) {
        compare = compareAttributes(id);
      }
      return compare;
    }
    throw new IdError('${_concept.code}.id is not defined.');
  }

  String _dropEnd(String text, String end) {
    String withoutEnd = text;
    int endPosition = text.lastIndexOf(end);
    if (endPosition > 0) {
      // Drop the end.
      withoutEnd = text.substring(0, endPosition);
    }
    return withoutEnd;
  }

   /**
   * Returns a string that represents this id.
   */
  String toString() {
     String result = '' ;
     if (parentLength > 0) {
       _parentMap.forEach((k,v) => result = '$result ${v},');
     }
     if (attributeLength > 0) {
       _attributeMap.forEach((k,v) => result = '$result ${v},');
     }
    return '(${_dropEnd(result.trim(), ',')})';
  }

  display([String title='Id']) {
    if (title != '') {
      print('');
      print('======================================');
      print('$title                                ');
      print('======================================');
      print('');
    }
    print(toString());
  }

}
