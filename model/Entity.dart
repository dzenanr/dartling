
class Entity<T extends Entity<T>> implements Comparable {

  Oid oid;
  String _code;

  Concept concept;

  Map<String, Object> attributeMap;
  Map<String, Entity> parentMap;
  Map<String, Entities> childMap;

  Entity() {
    oid = new Oid();
  }

  Entity.of(this.concept) {
    oid = new Oid();
    attributeMap = new Map<String, Object>();
    parentMap = new Map<String, Entity>();
    childMap = new Map<String, Entities>();
    for (Attribute a in concept.attributes) {
      if (a.init != null) {
        attributeMap[a.code] = a.init;
      } else if (a.increment != null) {
        attributeMap[a.code] = a.increment;
      } else {
        attributeMap[a.code] = null;
      }
    }
    for (Neighbor n in concept.destinations) {
      if (n.child) {
        var entities = new Entities();
        entities.concept = n.destinationConcept;
        childMap[n.code] = entities;
      } else {
        parentMap[n.code] = null;
      }
    }
  }

  String get code() => _code;
  set code(String c) {
    if (code != null) {
      throw new Exception('Entity code cannot be updated.');
    }
    if (c == null) {
      throw new Exception('Entity code cannot be null.');
    }
    _code = c;
  }

  Object getAttribute(String name) => attributeMap[name];
  setAttribute(String name, Object value) {
    //Attribute attribute = concept.attributes.getEntity(name);
    attributeMap[name] = value;
  }

  Entity getParent(String name) => parentMap[name];
  setParent(String name, Entity entity) => parentMap[name] = entity;

  Entities getChild(String name) => childMap[name];
  setChild(String name, Entities entities) => childMap[name] = entities;

  /**
   * Copies the entity (oid, code, attributes and neighbors).
   */
  T copy() {
    T e = new Entity.of(concept);
    e.oid = oid;
    e.code = code;
    for (Attribute a in concept.attributes) {
      attributeMap[a.code] = getAttribute(a.code);
    }
    for (Neighbor n in concept.destinations) {
      if (n.child) {
        childMap[n.code] = getChild(n.code);
      } else {
        parentMap[n.code] = getParent(n.code);;
      }
    }
    return e;
  }

  /**
  * Checks if the entity is equal to the given object.
  * If the given object is not of the T type,
  * two objects cannot be equal.
  * Two entities are equal if their oids are equal.
  */
  bool equals(other) {
    if (other is T) {
      if (oid != other.oid) {
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
   bool equalsInContent(other) {
     if (other is T) {
       if (code != other.code) {
         return false;
       }
       for (Attribute a in concept.attributes) {
         if (attributeMap[a.code] != other.getAttribute(a.code)) {
           return false;
         }
       }
       for (Neighbor n in concept.destinations) {
         if (n.parent) {
           if (parentMap[n.code] != other.getParent(n.code)) {
             return false;
           }
         } else if (childMap[n.code] != other.getChild(n.code)) {
           return false;
         }
       }
     } else {
       return false;
     }
     return true;
   }

  /**
   * Compares two entities based on codes. If the result is less than 0 then
   * the first entity is less than the second, if it is equal to 0 they are
   * equal and if the result is greater than 0 then the first is greater than
   * the second.
   */
  int compareTo(T entity) {
    return code.compareTo(entity.code);
  }

  /**
   * Returns a string that represents this entity by using oid and code.
   */
  String toString() {
    return '${oid.toString()} $code';
  }

  display([bool withOid=false, String s='']) {
    var s2 = s;
    if (concept != null && !concept.entry) {
      s2 = '$s  ';
    }
    print('${s2}----------');
    print('${s2}$code');
    print('${s2}----------');
    if (withOid) {
      print('${s2}oid: $oid');
    }
    print('${s2}code: $code');

    attributeMap.forEach((k,v) {
      print('${s2}$k: $v');
    });

    parentMap.forEach((k,v) {
      print('${s2}$k: ${v.code}');
    });

    childMap.forEach((k,v) {
      print('${s2}$k:');
      v.display(withOid, s2);
    });
  }

}
