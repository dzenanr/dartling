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

#source('transfer/json.dart');

#source('test/user/data.dart');

#source('test/web/data.dart');
#source('test/web/model.dart');

#source('data/user/Data.dart');
#source('data/user/Member.dart');
#source('data/user/Members.dart');

#source('data/web/Data.dart');
#source('data/web/Category.dart');
#source('data/web/Categories.dart');
#source('data/web/WebLink.dart');
#source('data/web/WebLinks.dart');

void main() {
  testUserData();
  testWebModel();
  testWebData();
}