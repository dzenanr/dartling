
class Id implements Comparable {

  Concept _concept;

  Map<String, Entity> _parentMap;
  Map<String, Object> _attributeMap;

  Id(this._concept) {
    _parentMap = new Map<String, Entity>();
    _attributeMap = new Map<String, Object>();
    for (Parent p in _concept.parents) {
      if (p.id) {
        _parentMap[p.code] = null;
      }
    }
    for (Attribute a in concept.attributes) {
      if (a.id) {
        _attributeMap[a.code] = null;
      }
    }
  }

  Concept get concept() => _concept;

  int get parentCount() => _parentMap.length;
  int get attributeCount() => _attributeMap.length;
  int get count() => parentCount + attributeCount;

  Entity getParent(String code) => _parentMap[code];
  setParent(String code, Entity parent) => _parentMap[code] = parent;

  Object getAttribute(String code) => _attributeMap[code];
  setAttribute(String code, Object attribute) => _attributeMap[code] = attribute;

  /**
   * Two ids are equal if their parents are equal.
   */
   bool equalParents(Id id) {
     for (Parent p in _concept.parents) {
       if (p.id) {
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
       if (a.id) {
         if (_attributeMap[a.code] != id.getAttribute(a.code)) {
           return false;
         }
       }
     }
     return true;
   }

  /**
   * Checks if the id is equal in content to the given object.
   * If the given object is not of the Id type,
   * two objects cannot be equal. Two ids are
   * equal if they have the same content.
   */
   bool equals(other) {
     if (other is Id) {
       var id = other;
       if (_concept != id.concept) {
         return false;
       }
       if (!equalParents(id)) {
         return false;
       }
       if (!equalAttributes(id)) {
         return false;
       }
     } else {
       return false;
     }
     return true;
   }

   /**
    * Compares two ids based on parents.
    * If the result is less than 0 then the first id is less than the second,
    * if it is equal to 0 they are equal and
    * if the result is greater than 0 then the first is greater than the second.
    */
   int compareParents(Id id) {
     if (id.parentCount > 0) {
       var compare = 0;
       for (Parent p in _concept.parents) {
         if (p.id) {
           compare = _parentMap[p.code].id.compareTo(id.getParent(p.code).id);
           if (compare != 0) {
             break;
           }
         }
       }
       return compare;
     }
     throw new IdException('${_concept.code}.id does not have parents.');
   }

   /**
    * Compares two ids based on attributes.
    * If the result is less than 0 then the first id is less than the second,
    * if it is equal to 0 they are equal and
    * if the result is greater than 0 then the first is greater than the second.
    */
   int compareAttributes(Id id) {
     if (id.attributeCount > 0) {
       var compare = 0;
       for (Attribute a in concept.attributes) {
         if (a.id) {
           if (a.type.base == 'String') {
             if (_attributeMap[a.code] is String) {
               String attributeString = _attributeMap[a.code];
               compare = attributeString.compareTo(id.getAttribute(a.code));
             } else {
               String msg =
                   '${a.concept.code}.${a.code} is not of String type.';
               throw new TypeException(msg);
             }
           }
           if (compare != 0) {
             break;
           }
         }
       }
       return compare;
     }
     throw new IdException('${_concept.code}.id does not have attributes.');
   }

   /**
   * Compares two ids based on parent entity ids and attributes.
   * If the result is less than 0 then the first id is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Id id) {
    if (id.count > 0) {
      var compare = compareParents(id);
      if (compare == 0) {
        compare = compareAttributes(id);
      }
      return compare;
    }
    throw new IdException('${_concept.code}.id is not defined.');
  }

   /**
   * Returns a string that represents this id.
   */
  String toString() {
     String result = '' ;
     if (parentCount > 0) {
       _parentMap.forEach((k,v) => result = '$result ${v}');
     }
     if (attributeCount > 0) {
       _attributeMap.forEach((k,v) => result = '$result ${v}');
     }
    return '(${result.trim()})';
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
