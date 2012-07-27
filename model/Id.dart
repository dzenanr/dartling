
class Id {

  Concept _concept;

  Map<String, Entity> _idParentMap;
  Map<String, Object> _idAttributeMap;

  Id(this._concept) {
    _idParentMap = new Map<String, Entity>();
    _idAttributeMap = new Map<String, Object>();
    for (Parent p in _concept.parents) {
      if (p.id) {
        _idParentMap[p.code] = null;
      }
    }
    for (Attribute a in concept.attributes) {
      if (a.id) {
        _idAttributeMap[a.code] = null;
      }
    }
  }

  Concept get concept() => _concept;

  int get parentCount() => _idParentMap.length;
  int get attributeCount() => _idAttributeMap.length;
  int get count() => parentCount + attributeCount;

  Entity getIdParent(String code) => _idParentMap[code];
  setParent(String code, Entity parent) => _idParentMap[code] = parent;

  Object getIdAttribute(String code) => _idAttributeMap[code];
  setAttribute(String code, Object value) => _idAttributeMap[code] = value;

  /**
   * Checks if the id is equal in content to the given object.
   * If the given object is not of the Id type,
   * two objects cannot be equal. Two ids are
   * equal if they have the same content.
   */
   bool equals(other) {
     if (other is Id) {
       if (_concept != other.concept) {
         return false;
       }
       for (Parent p in _concept.parents) {
         if (p.id) {
           if(_idParentMap[p.code] != other._idParentMap[p.code]) {
             return false;
           }
         }
       }
       for (Attribute a in concept.attributes) {
         if (a.id) {
           if(_idAttributeMap[a.code] != other._idAttributeMap[a.code]) {
             return false;
           }
         }
       }
     } else {
       return false;
     }
     return true;
   }

}
