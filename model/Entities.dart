
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

  add(T entity) {
    if (entity.code == null) {
      throw new NullPointerException('Entity code cannot be null.');
    }
    if (entityMap[entity.code] != null) {
      throw new IllegalArgumentException('Entity code must be unique.');
    }
    entityList.add(entity);
    entityMap[entity.code] = entity;
  }

  bool contains(T entity) {
    return entityMap.containsKey(entity.code);
  }

  clear() {
    entityList.clear();
    entityMap.clear();
  }

  remove(T entity) {
    for (T element in entityList) {
      if (element == entity) {
        int index = entityList.indexOf(element, 0);
        entityList.removeRange(index, 1);
        entityMap.remove(entity.code);
      }
    }
  }

  List<T> filter(Function f) => entityList.filter(f);

  T getEntity(String name) => entityMap[name];

  display([bool withOid=false, String s='']) {
    for (T e in entityList) {
      e.display(withOid, s);
    }
  }

}
