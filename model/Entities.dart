
class Entities<T extends Entity<T>> implements Iterable<Entity> {
  
  Concept concept;
  
  List<T> entityList;
  Map<String, T> entityMap;
  
  Entities() {
    entityList = new List<T>();
    entityMap = new Map<String, T>();
  }
  
  Entities.of(this.concept) {
    entityList = new List<T>();
    entityMap = new Map<String, T>();
  }
  
  Iterator<T> iterator() => entityList.iterator();
  
  int get length() => entityList.length;
  
  bool get isEmpty() => entityList.isEmpty();
  
  // in future: return bool
  void add(T entity) {
    entityList.add(entity);
    if (entity.code == null) {
      throw new NullPointerException('Entity code must be used.');
    }
    if (entityMap[entity.code] != null) {
      throw new IllegalArgumentException('Entity code must be unique.');
    }
    entityMap[entity.code] = entity;
  }
  
  bool contains(T entity) {
    return entityMap.containsKey(entity.code);
  }
  
  void clear() {
    entityList.clear();
    entityMap.clear();
  }
  
  bool remove(T entity) {
    for (T element in entityList) {
      if (element == entity) {
        int index = entityList.indexOf(element, 0);
        entityList.removeRange(index, 1);
        entityMap.remove(entity.code);
        return true;
      }
    }
    return false;
  }
  
  List<T> filter(Function f) => entityList.filter(f);
  
  T getEntity(String code) => entityMap[code];
  
  display([bool withOid=false, String s='']) {
    for (T e in entityList) {
      e.display(withOid, s);
    }
  }
  
}
