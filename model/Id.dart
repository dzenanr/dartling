
class Id {

  Concept _concept;

  Map<String, Entity> _idParentMap;
  Map<String, Object> _idAttributeMap;

  Id(this._concept) {
    _idParentMap = new Map<String, Parent>();
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

  Entity getIdParent(String code) => _idParentMap[code];
  setParent(String code, Entity entity) => _idParentMap[code] = entity;

  Object getIdAttribute(String code) => _idAttributeMap[code];
  setAttribute(String code, Object value) => _idAttributeMap[code] = value;

}
