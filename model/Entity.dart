
class Entity<T extends Entity<T>> implements Comparable {

  Oid oid;
  String code;

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
