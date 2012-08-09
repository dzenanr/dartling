/*
http://opensource.org/licenses/

http://en.wikipedia.org/wiki/BSD_license
3-clause license ("New BSD License" or "Modified BSD License")

Copyright (c) 2012, Dartling project authors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Dartling nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#library('Dartling');

#import('../unittest/unittest.dart');
#import('dart:json');
#import('dart:uri');

#source('data/domain/model/link/categories.dart');
#source('data/domain/model/link/data.dart');
#source('data/domain/model/link/webLinks.dart');
#source('data/domain/model/project/data.dart');
#source('data/domain/model/project/projects.dart');
#source('data/domain/model/user/data.dart');
#source('data/domain/model/user/members.dart');
#source('data/domain/model/institution/data.dart');
#source('data/domain/model/institution/ecoles.dart');

#source('meta/attributes.dart');
#source('meta/children.dart');
#source('meta/concepts.dart');
#source('meta/domains.dart');
#source('meta/models.dart');
#source('meta/neighbor.dart');
#source('meta/parents.dart');
#source('meta/property.dart');
#source('meta/types.dart');

#source('repository/domain/model/event/reactions.dart');
#source('repository/domain/model/event/actions.dart');
#source('repository/domain/model/exception/errors.dart');
#source('repository/domain/model/exception/exceptions.dart');
#source('repository/domain/model/transfer/json.dart');
#source('repository/domain/model/data.dart');
#source('repository/domain/model/entities.dart');
#source('repository/domain/model/entity.dart');
#source('repository/domain/model/id.dart');
#source('repository/domain/model/oid.dart');
#source('repository/domain/data.dart');
#source('repository/domain/session.dart');
#source('repository/repository.dart');

#source('test/domain/model/institution/data.dart');
#source('test/domain/model/link/data.dart');
#source('test/domain/model/link/model.dart');
#source('test/domain/model/project/data.dart');
#source('test/domain/model/user/data.dart');
#source('test/lastGroupTest.dart');
#source('test/lastSingleTest.dart');

InstitutionData fromJsonToInstitutionData(Domain domain, [String modelCode = 'default']) {
  /**
   *  || Ecole
   *  at numero
   *  at nom
   */
  var _json = '''
      {"width":990,"lines":[],"height":580,
       "boxes":[
         {"entry":true,"name":"Ecole",
          "x":342,"y":252,"width":120,"height":120,
          "items":[
           {"sequence":10,"category":"attribute","name":"numero",
            "type":"int","init":""
           },
           {"sequence":20,"category":"attribute","name":"nom",
            "type":"String","init":""
           }]
         }]
       }
  ''';
  return new InstitutionData(fromMagicBoxes(_json, domain, modelCode));
}

ProjectData fromJsonToProjectData(Domain domain, [String modelCode = 'default']) {
  /**
   *  || Project
   *  id name
   *  at description
   */
  var _json = '''
      {"width":990,"height":580,"lines":[],
       "boxes":[
        {"entry":true,"name":"Project",
         "x":179,"y":226,"width":120,"height":120,
         "items":[
          {"sequence":10,"category":"identifier","name":"name",
           "type":"String","init":""
          },
          {"sequence":20,"category":"attribute","name":"description",
           "type":"String","init":""
          }]
        }]
      }
  ''';
  return new ProjectData(fromMagicBoxes(_json, domain, modelCode));
}

UserData fromJsonToUserData(Domain domain, [String modelCode = 'default']) {
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
      {"width":990,"lines":[],"height":580,"boxes":[{"entry":true,"name":"Member",
      "x":207,"y":160,"width":100,"height":180,"items":[{"sequence":10,
      "category":"identifier","name":"email","type":"Email","init":""},
      {"sequence":20,"category":"required","name":"firstName","type":"String",
      "init":""},{"sequence":30,"category":"required","name":"lastName",
      "type":"String","init":""},{"sequence":40,"category":"required",
      "name":"started","type":"Date","init":"now"},{"sequence":50,
      "category":"attribute","name":"receiveEmail","type":"bool","init":"false"},
      {"sequence":60,"category":"required","name":"password","type":"String",
      "init":""},{"sequence":70,"category":"required","name":"role","type":"String",
      "init":"regular"},{"sequence":80,"category":"attribute","name":"karma",
      "type":"num","init":"1"},{"sequence":90,"category":"attribute",
      "name":"about","type":"String","init":""}]}]}
  ''';
  return new UserData(fromMagicBoxes(_json, domain, modelCode));
}

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
  var _json = '''
    {"width":990,"lines":[{"box2box1Min":"1","box1Name":"Category",
    "box1box2Min":"0","box2Name":"WebLink","category":"relationship",
    "box2box1Id":true,"box2box1Name":"category","box1box2Id":false,
    "box1box2Name":"webLinks","box1box2Max":"N","internal":true,
    "box2box1Max":"1"}],"height":580,"boxes":[{"entry":true,"name":"Category",
    "x":146,"y":201,"width":120,"height":120,"items":[{"sequence":20,
    "category":"identifier","name":"name","type":"String","init":""},
    {"sequence":30,"category":"attribute","name":"description",
    "type":"String","init":""}]},{"entry":false,"name":"WebLink",
    "x":505,"y":215,"width":120,"height":120,
    "items":[{"sequence":20,"category":"identifier","name":"name",
    "type":"String","init":""},{"sequence":30,"category":"required",
    "name":"url","type":"String","init":""},{"sequence":40,
    "category":"attribute","name":"description","type":"String","init":""}]}]}
  ''';
  return new LinkData(fromMagicBoxes(_json, domain, modelCode));
}

void main() {
  var domains = new Domains();
  var defaultDomain = new Domain();
  domains.add(defaultDomain);
  var defaultDomainData = new DomainData(defaultDomain);
  var repo = new Repo(domains);
  repo.add(defaultDomainData);

  var institutionModelCode = 'Institution';
  var institutionData =
      fromJsonToInstitutionData(defaultDomain, institutionModelCode);
  defaultDomainData.add(institutionData);
  testInstitutionData(repo, institutionModelCode);

  var projectModelCode = 'Project';
  var projectData = fromJsonToProjectData(defaultDomain, projectModelCode);
  defaultDomainData.add(projectData);
  testProjectData(repo, projectModelCode);

  var userModelCode = 'User';
  var userData = fromJsonToUserData(defaultDomain, userModelCode);
  defaultDomainData.add(userData);
  testUserData(repo, userModelCode);

  var linkModelCode = 'Link';
  var linkData = fromJsonToLinkData(defaultDomain, linkModelCode);
  defaultDomainData.add(linkData);
  testLinkData(repo, linkModelCode);

  testLinkModel();

  //lastSingleTest();
  //lastGroupTest();
}