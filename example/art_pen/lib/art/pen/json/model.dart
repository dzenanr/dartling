part of art_pen;

// http://www.json.org/
// http://jsonformatter.curiousconcept.com/

// rename dartling to yourDomainName
// rename Skeleton to YourModelName
// do not change model or Model

// src/data/dartling/skeleton/json/model.dart

var artPenModelJson = r'''
{
   "width":990,
   "lines":[
      {
         "box2box1Min":"1",
         "box1Name":"Segment",
         "box1box2Min":"0",
         "box2Name":"Line",
         "category":"relationship",
         "box2box1Id":false,
         "box2box1Name":"segment",
         "box1box2Id":false,
         "box1box2Name":"lines",
         "box1box2Max":"N",
         "internal":true,
         "box2box1Max":"1"
      }
   ],
   "height":580,
   "boxes":[
      {
         "entry":true,
         "name":"Segment",
         "x":54,
         "y":41,
         "width":80,
         "height":80,
         "items":[
            {
               "sequence":50,
               "category":"required",
               "name":"visible",
               "type":"bool",
               "init":"true"
            },
            {
               "sequence":60,
               "category":"required",
               "name":"color",
               "type":"String",
               "init":"black"
            },
            {
               "sequence":70,
               "category":"required",
               "name":"width",
               "type":"int",
               "init":"1"
            }
         ]
      },
      {
         "entry":false,
         "name":"Line",
         "x":315,
         "y":149,
         "width":100,
         "height":140,
         "items":[
            {
               "sequence":30,
               "category":"required",
               "name":"beginX",
               "type":"num",
               "init":""
            },
            {
               "sequence":40,
               "category":"required",
               "name":"beginY",
               "type":"num",
               "init":""
            },
            {
               "sequence":50,
               "category":"required",
               "name":"endX",
               "type":"num",
               "init":""
            },
            {
               "sequence":70,
               "category":"required",
               "name":"endY",
               "type":"num",
               "init":""
            },
            {
               "sequence":80,
               "category":"required",
               "name":"cumulativeAngle",
               "type":"num",
               "init":"0"
            },
            {
               "sequence":90,
               "category":"required",
               "name":"angle",
               "type":"num",
               "init":"0"
            },
            {
               "sequence":100,
               "category":"required",
               "name":"pixels",
               "type":"num",
               "init":"80"
            }
         ]
      }
   ]
}
''';