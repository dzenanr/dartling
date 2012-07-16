#import('../../unittest/unittest.dart');

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
#source('meta/Properties.dart');
#source('meta/Attribute.dart');
#source('meta/Attributes.dart');
#source('meta/Neighbor.dart');
#source('meta/Neighbors.dart');

#source('model/Entity.dart');
#source('model/Entities.dart');
#source('model/Entry.dart');

#source('web/Library.dart');
#source('web/Category.dart');
#source('web/Categories.dart');
#source('web/WebLink.dart');
#source('web/WebLinks.dart');

#source('test/entry.dart');
#source('test/library.dart');
#source('test/unit.dart');

void main() {
  createModelEntry();
  createWebLibrary();
  tests();
}