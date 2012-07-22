
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
    Type intType = new Type(this, 'int');
    Type boolType = new Type(this, 'bool');
    assert(types.count == 3);
  }

  Domain getDomain(String name) => domains.getEntity(name);

  Model get model() => models.getEntity('default');

  Model getModel(String code) => models.getEntity(code);

  Type getType(String code) => types.getEntity(code);
}
