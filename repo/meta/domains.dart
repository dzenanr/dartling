
class Domains extends Entities<Domain> {

  Domain getDomain(String code) => findByCode(code);

}

class Domain extends ConceptEntity<Domain> {

  String description;

  Domain domain;

  Domains domains;
  Types types;
  Models models;

  Domain([String domainCode = 'Default']) {
    super.code = domainCode;
    domains = new Domains();
    types = new Types();
    models = new Models();
    if (domainCode == 'Default') {
      description = 'Default domain to keep types and models.';
    }

    new Type(this, 'String');
    new Type(this, 'num');
    new Type(this, 'int');
    new Type(this, 'double');
    new Type(this, 'bool');
    new Type(this, 'Date');
    new Type(this, 'Uri');
    assert(types.count == 7);
  }

  Domain getDomain(String domainCode) => domains.findByCode(domainCode);

  Model getModel(String modelCode) => models.findByCode(modelCode);

  Type getType(String typeCode) => types.findByCode(typeCode);

}
