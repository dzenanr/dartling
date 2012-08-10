
LinkEntries fromJsonToLinkEntries(Domain domain,
                                  [String modelCode = 'default']) {
  /**
   *  https://dl.dropbox.com/u/161496/dart/mb/model/Link.png
   *
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
   *  0N interests
   *
   *  Interest
   *  at description
   *  id category (external parent)
   *  id member
   *
   *  || Category
   *  id name
   *  at description
   *  rq approved (init: false)
   *  0N webLinks
   *  0N interests
   *
   *  WebLink
   *  id name
   *  rq url
   *  at description
   *  rq created (init: now)
   *  at updated (init: false)
   *  rq approved (init: false)
   *  id category
   */
  var json = '''
    {"width":990,"height":580,
     "lines":[
      {"box2box1Min":"1","box1Name":"Category","box1box2Min":"0",
       "box2Name":"WebLink","category":"relationship","box2box1Id":true,
       "box2box1Name":"category","box1box2Id":false,"box1box2Name":"webLinks",
       "box1box2Max":"N","internal":true,"box2box1Max":"1"},{"box2box1Min":"1",
       "box1Name":"Category","box1box2Min":"0","box2Name":"Interest",
       "category":"relationship","box2box1Id":true,"box2box1Name":"category",
       "box1box2Id":false,"box1box2Name":"interests","box1box2Max":"N",
       "internal":false,"box2box1Max":"1"},{"box2box1Min":"1",
       "box1Name":"Member","box1box2Min":"0","box2Name":"Interest",
       "category":"relationship","box2box1Id":true,"box2box1Name":"member",
       "box1box2Id":false,"box1box2Name":"interests","box1box2Max":"N",
       "internal":true,"box2box1Max":"1"
     }],
     "boxes":[
      {"entry":true,"name":"Member",
       "x":41,"y":312,"width":100,"height":180,
       "items":[
         {"sequence":10,"category":"identifier","name":"email","type":"Email","init":""},
         {"sequence":20,"category":"required","name":"firstName","type":"String","init":""},
         {"sequence":30,"category":"required","name":"lastName","type":"String","init":""},
         {"sequence":40,"category":"required","name":"started","type":"Date","init":"now"},
         {"sequence":50,"category":"attribute","name":"receiveEmail","type":"bool","init":"false"},
         {"sequence":60,"category":"required","name":"password","type":"String","init":""},
         {"sequence":70,"category":"required","name":"role","type":"String","init":"regular"},
         {"sequence":80,"category":"attribute","name":"karma","type":"num","init":"1"},
         {"sequence":90,"category":"attribute","name":"about","type":"String","init":""}]
      },
      {"entry":true,"name":"Category",
       "x":39,"y":73,"width":100,"height":80,
       "items":[
         {"sequence":20,"category":"identifier","name":"name","type":"String","init":""},
         {"sequence":30,"category":"attribute","name":"description","type":"String","init":""},
         {"sequence":40,"category":"required","name":"approved","type":"bool","init":"false"}]
      },
      {"entry":false,"name":"WebLink",
       "x":375,"y":177,"width":100,"height":140,
       "items":[
         {"sequence":20,"category":"identifier","name":"name","type":"String","init":""},
         {"sequence":30,"category":"required","name":"url","type":"String","init":""},
         {"sequence":40,"category":"attribute","name":"description","type":"String","init":""},
         {"sequence":50,"category":"required","name":"created","type":"Date","init":"now"},
         {"sequence":60,"category":"attribute","name":"updated","type":"Date","init":"false"},
         {"sequence":70,"category":"required","name":"approved","type":"bool","init":"false"}]
      },
      {"entry":false,"name":"Interest",
       "x":377,"y":377,"width":100,"height":60,
       "items":[
         {"sequence":10,"category":"attribute","name":"description","type":"String","init":""}]
      }]
    }
  ''';
  return new LinkEntries(fromMagicBoxes(json, domain, modelCode));
}

class LinkEntries extends ModelEntries {

  LinkEntries(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Category');
    if (concept.entry) {
      entries[concept.code] = new Categories(concept);
    }
    concept = model.concepts.findByCode('Member');
    if (concept.entry) {
      entries[concept.code] = new Members(concept);
    }
    return entries;
  }

  Categories get categories() => getEntry('Category');
  Members get members() => getEntry('Member');

  Concept get categoryConcept() => categories.concept;
  Concept get memberConcept() => members.concept;
  Concept get webLinkConcept() => model.concepts.findByCode('WebLink');
  Concept get interestConcept() => model.concepts.findByCode('Interest');

}


