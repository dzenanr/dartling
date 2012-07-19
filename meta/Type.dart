
class Type extends Entity<Type> {
  
  String base;
  int length;
  
  Domain domain;
  
  Type(this.domain, String code) {
    super.code = code;
    base = code;
    domain.types.add(this);
  }
  
}
