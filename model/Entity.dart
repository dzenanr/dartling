
class Entity<T extends Entity<T>> implements Comparable {
  
  Oid oid;
  String code;
  
  Concept concept;
  
  Map<String, Object> attributes;
  Map<String, Entity> parents;
  Map<String, Entities> children;
  
  Entity() {
    oid = new Oid();
    attributes = new Map<String, Object>();
    parents = new Map<String, Entity>();
    children = new Map<String, Entities>();
  }
  
  Entity.of(this.concept) {
    oid = new Oid();
    attributes = new Map<String, Object>();
    parents = new Map<String, Entity>();
    children = new Map<String, Entities>();
    for (Attribute a in concept.childAttributes) {
      if (a.init != null) {
        attributes[a.code] = a.init;
      } else if (a.increment != null) {
        attributes[a.code] = a.increment;
      } else {
        attributes[a.code] = null;
      }
    }
    for (Neighbor n in concept.childDestinations) {
      if (n.child) {
        var entities = new Entities();
        entities.concept = n.destinationConcept;
        children[n.code] = entities;
      } else {
        parents[n.code] = null;
      }
    }
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
    
    attributes.forEach((k,v) {
      print('${s2}$k: $v');
    });
    
    parents.forEach((k,v) {
      print('${s2}$k: ${v.code}');
    });
    
    children.forEach((k,v) {
      print('${s2}$k:');
      v.display(withOid, s2);
    });
  }
  
}
