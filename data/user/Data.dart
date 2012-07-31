
class UserData {

  Concept memberConcept;

  Members members;

  /**
   *  || Member (code)
   *  id email : String
   *  rq firstName : String
   *  rq lastName : String
   *  rq started : Date (init : now)
   *  at receiveEmail : bool (init : false)
   *  rq password : String
   *  rq role : String (init : regular)
   *  at karma : num (init : 1)
   *  at about : String
   */
  var _json = '''
    {"width":990,"lines":[],"height":580,"boxes":[{"entry":true,"name":"Member","x":207,"y":160,"width":100,"height":180,"items":[{"sequence":10,"category":"identifier","name":"email","type":"Email","init":""},{"sequence":20,"category":"required","name":"firstName","type":"String","init":""},{"sequence":30,"category":"required","name":"lastName","type":"String","init":""},{"sequence":40,"category":"required","name":"started","type":"Date","init":"now"},{"sequence":50,"category":"attribute","name":"receiveEmail","type":"bool","init":"false"},{"sequence":60,"category":"required","name":"password","type":"String","init":""},{"sequence":70,"category":"required","name":"role","type":"String","init":"regular"},{"sequence":80,"category":"attribute","name":"karma","type":"num","init":"1"},{"sequence":90,"category":"attribute","name":"about","type":"String","init":""}]}]}
  ''';

  UserData() {
    Domain domain = fromMagicBoxes(_json);
    Model model = domain.model;
    memberConcept = model.concepts.getEntityByCode('Member');
    members = new Members(memberConcept);
  }

}
