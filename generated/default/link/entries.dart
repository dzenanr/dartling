
LinkData fromJsonToLinkData(Domain domain, [String modelCode = 'default']) {
  /**
   *  || Category
   *  id name
   *  at description
   *  0N webLinks
   *
   *  WebLink
   *  id name
   *  rq url
   *  at description
   *  id category
   */
  var json = '''
    {"width":990,"height":580,
     "lines":[
       {"box2box1Min":"1","box1Name":"Category",
        "box1box2Min":"0","box2Name":"WebLink","category":"relationship",
        "box2box1Id":true,"box2box1Name":"category","box1box2Id":false,
        "box1box2Name":"webLinks","box1box2Max":"N","internal":true,
        "box2box1Max":"1"
       }],
     "boxes":[
      {"entry":true,"name":"Category",
       "x":146,"y":201,"width":120,"height":120,
       "items":[
        {"sequence":20,"category":"identifier","name":"name",
         "type":"String","init":""},
        {"sequence":30,"category":"attribute","name":"description",
         "type":"String","init":""
        }]
      },
      {"entry":false,"name":"WebLink",
       "x":505,"y":215,"width":120,"height":120,
       "items":[
        {"sequence":20,"category":"identifier","name":"name",
         "type":"String","init":""},
        {"sequence":30,"category":"required","name":"url",
         "type":"String","init":""},
        {"sequence":40,"category":"attribute","name":"description",
         "type":"String","init":""
        }]
      }]
    }
  ''';
  return new LinkData(fromMagicBoxes(json, domain, modelCode));
}

class LinkData extends ModelEntries {

  LinkData(Model model) : super(model);

  Map<String, Entities> newEntries() {
    var entries = new Map<String, Entities>();
    var concept = model.concepts.findByCode('Category');
    entries[concept.code] = new Categories(concept);
    return entries;
  }

  Categories get categories() => getEntry('Category');

  Concept get categoryConcept() => categories.concept;
  Concept get webLinkConcept() => model.concepts.findByCode('WebLink');

}


