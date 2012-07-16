
class Domain extends Entity<Domain> {
  
  String description;
  
  Domain parentDomain;
  
  Domains childDomains;
  Types childTypes;
  Models childModels;
  
  Domain([String code = 'default']) {
    super.code = code;
    childDomains = new Domains();
    childTypes = new Types();
    childModels = new Models();
    if (code == 'default') {
      description = 'Default domain to keep types and models.';
    }
    
    Type stringType = new Type(this, 'String');
    Type intType = new Type(this, 'int');
    Type boolType = new Type(this, 'bool');
    assert(childTypes.length == 3);
  }
  
}
