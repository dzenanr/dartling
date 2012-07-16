
class Type extends Entity<Type> {
  
  String base;
  int length;
  
  Domain parentDomain;
  
  Type(this.parentDomain, String code) {
    super.code = code;
    base = code;
    parentDomain.childTypes.add(this);
  }
  
}
