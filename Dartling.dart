#import('../../unittest/unittest.dart');
#import('dart:json');

#source('data/project/Data.dart');
#source('data/project/Project.dart');
#source('data/project/Projects.dart');

#source('data/user/Data.dart');
#source('data/user/Member.dart');
#source('data/user/Members.dart');

#source('data/web/Categories.dart');
#source('data/web/Category.dart');
#source('data/web/Data.dart');
#source('data/web/WebLink.dart');
#source('data/web/WebLinks.dart');

#source('exception/AddException.dart');
#source('exception/CodeException.dart');
#source('exception/ConceptException.dart');
#source('exception/DartlingException.dart');
#source('exception/Error.dart');
#source('exception/Errors.dart');
#source('exception/RemoveException.dart');
#source('exception/UpdateException.dart');

#source('guid/Oid.dart');

#source('meta/Attribute.dart');
#source('meta/Attributes.dart');
#source('meta/Child.dart');
#source('meta/Children.dart');
#source('meta/Concept.dart');
#source('meta/Concepts.dart');
#source('meta/Domain.dart');
#source('meta/Domains.dart');
#source('meta/Model.dart');
#source('meta/Models.dart');
#source('meta/Neighbor.dart');
#source('meta/Parent.dart');
#source('meta/Parents.dart');
#source('meta/Property.dart');
#source('meta/Type.dart');
#source('meta/Types.dart');

#source('model/Data.dart');
#source('model/Entities.dart');
#source('model/Entity.dart');
#source('model/Id.dart');

#source('test/bug.dart');
#source('test/project/data.dart');
#source('test/user/data.dart');
#source('test/web/data.dart');
#source('test/web/model.dart');

#source('transfer/json.dart');

allTests() {
  testProjectData();
  testUserData();
  testWebData();
  testWebModel();
}

void main() {
  //testBug();
  allTests();
}