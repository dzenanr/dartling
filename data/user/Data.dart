
class UserData {

  Concept memberConcept;

  Members members;

  var _json = '''
    {"width":990,"lines":[],"height":580,
    "boxes":[{"entry":true,"name":"Member",
    "x":207,"y":160,"width":120,"height":120,
    "items":[{"sequence":10,"category":"required","name":"firstName",
    "type":"String","init":""},{"sequence":20,"category":"required",
    "name":"lastName","type":"String","init":""},
    {"sequence":30,"category":"identifier",
    "name":"email","type":"Email","init":""}]}]}
  ''';

  UserData() {
    Domain domain = fromMagicBoxes(_json);
    Model model = domain.model;
    memberConcept = model.concepts.getEntityByCode('Member');
    members = new Members(memberConcept);
  }

}
