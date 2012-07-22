#import('../../unittest/unittest.dart');
#import('dart:json');

#source('meta/Oid.dart');
#source('meta/Domain.dart');
#source('meta/Domains.dart');
#source('meta/Type.dart');
#source('meta/Types.dart');
#source('meta/Model.dart');
#source('meta/Models.dart');
#source('meta/Concept.dart');
#source('meta/Concepts.dart');
#source('meta/Property.dart');
#source('meta/Attribute.dart');
#source('meta/Attributes.dart');
#source('meta/Neighbor.dart');
#source('meta/Parent.dart');
#source('meta/Parents.dart');
#source('meta/Child.dart');
#source('meta/Children.dart');

#source('model/Entity.dart');
#source('model/Entities.dart');
#source('model/Data.dart');

#source('web/Catalog.dart');
#source('web/Category.dart');
#source('web/Categories.dart');
#source('web/WebLink.dart');
#source('web/WebLinks.dart');

#source('transfer/json.dart');

#source('test/model.dart');
#source('test/catalog.dart');

void main() {
  dataTests();
  unitTests();
}