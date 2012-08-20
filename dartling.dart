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

#library('dartling');

#import('../unittest/unittest.dart');
#import('dart:json');
#import('dart:math');
#import('dart:uri');

#source('data/categoryquestion/link/json.dart');
#source('data/davidcurtis/institution/json.dart');
#source('data/default/project/json.dart');
#source('data/default/user/json.dart');

#source('generated/categoryquestion/link/categories.dart');
#source('generated/categoryquestion/link/comments.dart');
#source('generated/categoryquestion/link/entries.dart');
#source('generated/categoryquestion/link/interests.dart');
#source('generated/categoryquestion/link/members.dart');
#source('generated/categoryquestion/link/questions.dart');
#source('generated/categoryquestion/link/webLinks.dart');
#source('generated/categoryquestion/models.dart');
#source('generated/repository.dart');

#source('generated/davidcurtis/institution/ecoles.dart');
#source('generated/davidcurtis/institution/entries.dart');
#source('generated/davidcurtis/models.dart');

#source('generated/default/project/entries.dart');
#source('generated/default/project/projects.dart');
#source('generated/default/user/entries.dart');
#source('generated/default/user/users.dart');
#source('generated/default/models.dart');

#source('meta/attributes.dart');
#source('meta/children.dart');
#source('meta/concepts.dart');
#source('meta/domains.dart');
#source('meta/models.dart');
#source('meta/neighbor.dart');
#source('meta/parents.dart');
#source('meta/property.dart');
#source('meta/types.dart');

#source('model/categoryquestion/link/json.dart');
#source('model/davidcurtis/institution/json.dart');
#source('model/default/project/json.dart');
#source('model/default/user/json.dart');

#source('repository/domain/model/event/actions.dart');
#source('repository/domain/model/event/reactions.dart');
#source('repository/domain/model/exception/errors.dart');
#source('repository/domain/model/exception/exceptions.dart');
#source('repository/domain/model/transfer/json.dart');
#source('repository/domain/model/entities.dart');
#source('repository/domain/model/entity.dart');
#source('repository/domain/model/entries.dart');
#source('repository/domain/model/id.dart');
#source('repository/domain/model/oid.dart');
#source('repository/domain/models.dart');
#source('repository/domain/session.dart');
#source('repository/gen/generated.dart');
#source('repository/gen/specific.dart');
#source('repository/gen/test.dart');
#source('repository/repository.dart');

#source('specific/categoryquestion/link/categories.dart');
#source('specific/categoryquestion/link/comments.dart');
#source('specific/categoryquestion/link/interests.dart');
#source('specific/categoryquestion/link/members.dart');
#source('specific/categoryquestion/link/questions.dart');
#source('specific/categoryquestion/link/webLinks.dart');

#source('specific/davidcurtis/institution/ecoles.dart');

#source('specific/default/project/projects.dart');
#source('specific/default/user/users.dart');

#source('test/categoryquestion/link/data.dart');
#source('test/categoryquestion/link/model.dart');

#source('test/davidcurtis/institution/data.dart');

#source('test/default/project/data.dart');
#source('test/default/user/data.dart');

#source('test/lastgrouptest.dart');
#source('test/lastsingletest.dart');

testData() {
  var repo = new DartlingRepo();
  testCategoryQuestionLinkData(repo, DartlingRepo.categoryquestionDomainCode,
      DartlingRepo.categoryquestionLinkModelCode);
  testCategoryQuestionLinkModel();

  testDavidCurtisInstitutionData(repo, DartlingRepo.davidcurtisDomainCode,
      DartlingRepo.davidcurtisInstitutionModelCode);

  testDefaultProjectData(repo, DartlingRepo.defaultProjectModelCode);
  testDefaultUserData(repo, DartlingRepo.defaultUserModelCode);

  //lastSingleTest(repo, '', '');
  //lastGroupTest(repo, '', '');
}

genCode() {
  var domains = new Domains();
  var defaultDomain = new Domain();
  domains.add(defaultDomain);
  Model projectModel =
      fromMagicBoxes(defaultProjectModelInJson, defaultDomain, 'Project');
  //the model already added in the fromMagicBoxes function
  //defaultDomain.models.add(projectModel); // no need to add the model
  var repo = new Repo(domains);
  repo.gen();
}

void main() {
  genCode();
  testData();
}