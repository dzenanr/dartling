
class Domain extends Entity<Domain> {

  String description;

  Domain domain;

  Domains domains;
  Types types;
  Models models;

  Domain([String code = 'default']) {
    super.code = code;
    domains = new Domains();
    types = new Types();
    models = new Models();
    if (code == 'default') {
      description = 'Default domain to keep types and models.';
    }

    Type stringType = new Type(this, 'String');
    Type numType = new Type(this, 'num');
    Type intType = new Type(this, 'int');
    Type doubleType = new Type(this, 'double');
    Type boolType = new Type(this, 'bool');
    Type dateType = new Type(this, 'Date');
    assert(types.count == 6);
  }

  Domain getDomain(String code) => domains.getEntityByCode(code);

  Model get model() => models.getEntityByCode('default');

  Model getModel(String code) => models.getEntityByCode(code);

  Type getType(String code) => types.getEntityByCode(code);
}
