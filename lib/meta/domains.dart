part of dartling;

class Domains extends Entities<Domain> {

  Domain getDomain(String code) => findByCode(code);

}

class Domain extends ConceptEntity<Domain> {

  String description;

  Domain domain;

  Domains domains;
  AttributeTypes types;
  Models models;

  Domain([String domainCode = 'Default']) {
    super.code = domainCode;
    domains = new Domains();
    types = new AttributeTypes();
    models = new Models();
    if (domainCode == 'Default') {
      description = 'Default domain to keep types and models.';
    }

    new AttributeType(this, 'String');
    new AttributeType(this, 'num');
    new AttributeType(this, 'int');
    new AttributeType(this, 'double');
    new AttributeType(this, 'bool');
    new AttributeType(this, 'Date');
    new AttributeType(this, 'Uri');
    assert(types.length == 7);
  }

  Domain getDomain(String domainCode) => domains.findByCode(domainCode);

  Model getModel(String modelCode) => models.findByCode(modelCode);

  AttributeType getType(String typeCode) => types.findByCode(typeCode);

}
