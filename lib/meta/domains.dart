part of dartling;

class Domains extends Entities<Domain> {

  Domain getDomain(String code) => singleWhereCode(code);

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
    new AttributeType(this, 'DateTime');
    new AttributeType(this, 'Uri');
    assert(types.length == 7);
  }

  Domain getDomain(String domainCode) => domains.singleWhereCode(domainCode);

  Model getModel(String modelCode) => models.singleWhereCode(modelCode);

  AttributeType getType(String typeCode) => types.singleWhereCode(typeCode);

}
