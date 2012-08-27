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

//#import('package:unittest/unittest.dart');
#import('../unittest/unittest.dart');
#import('dart:json');
#import('dart:math');
#import('dart:uri');

#source('repo/code/generated/category_question/link/categories.dart');
#source('repo/code/generated/category_question/link/comments.dart');
#source('repo/code/generated/category_question/link/entries.dart');
#source('repo/code/generated/category_question/link/interests.dart');
#source('repo/code/generated/category_question/link/members.dart');
#source('repo/code/generated/category_question/link/questions.dart');
#source('repo/code/generated/category_question/link/webLinks.dart');
#source('repo/code/generated/category_question/models.dart');

#source('repo/code/generated/david_curtis/institution/ecoles.dart');
#source('repo/code/generated/david_curtis/institution/entries.dart');
#source('repo/code/generated/david_curtis/models.dart');
#source('repo/code/generated/default/project/entries.dart');
#source('repo/code/generated/default/project/projects.dart');
#source('repo/code/generated/default/user/entries.dart');
#source('repo/code/generated/default/user/users.dart');
#source('repo/code/generated/default/models.dart');
#source('repo/code/generated/repository.dart');

#source('repo/code/specific/category_question/link/categories.dart');
#source('repo/code/specific/category_question/link/comments.dart');
#source('repo/code/specific/category_question/link/interests.dart');
#source('repo/code/specific/category_question/link/members.dart');
#source('repo/code/specific/category_question/link/questions.dart');
#source('repo/code/specific/category_question/link/webLinks.dart');
#source('repo/code/specific/david_curtis/institution/ecoles.dart');
#source('repo/code/specific/default/project/projects.dart');
#source('repo/code/specific/default/user/users.dart');

#source('repo/code/specific/tests/category_question/link/data.dart');
#source('repo/code/specific/tests/category_question/link/model.dart');
#source('repo/code/specific/tests/david_curtis/institution/data.dart');
#source('repo/code/specific/tests/default/project/data.dart');
#source('repo/code/specific/tests/default/user/data.dart');
#source('repo/code/specific/tests/last_group_test.dart');
#source('repo/code/specific/tests/last_single_test.dart');

#source('repo/data/category_question/link/json.dart');
#source('repo/data/david_curtis/institution/json.dart');
#source('repo/data/default/project/json.dart');
#source('repo/data/default/user/json.dart');
#source('repo/data/model/category_question/link/json.dart');
#source('repo/data/model/david_curtis/institution/json.dart');
#source('repo/data/model/default/project/json.dart');
#source('repo/data/model/default/user/json.dart');

#source('repo/domain/model/event/actions.dart');
#source('repo/domain/model/event/reactions.dart');
#source('repo/domain/model/exception/errors.dart');
#source('repo/domain/model/exception/exceptions.dart');
#source('repo/domain/model/transfer/json.dart');
#source('repo/domain/model/entities.dart');
#source('repo/domain/model/entity.dart');
#source('repo/domain/model/entries.dart');
#source('repo/domain/model/id.dart');
#source('repo/domain/model/oid.dart');
#source('repo/domain/models.dart');
#source('repo/domain/session.dart');

#source('repo/gen/dartling.dart');
#source('repo/gen/generated.dart');
#source('repo/gen/specific.dart');
#source('repo/gen/tests.dart');

#source('repo/meta/attributes.dart');
#source('repo/meta/children.dart');
#source('repo/meta/concepts.dart');
#source('repo/meta/domains.dart');
#source('repo/meta/models.dart');
#source('repo/meta/neighbor.dart');
#source('repo/meta/parents.dart');
#source('repo/meta/property.dart');
#source('repo/meta/types.dart');

#source('repo/repository.dart');

genCode() {
  var repo = new Repo();
  var defaultDomain = new Domain();
  Model projectModel =
      fromMagicBoxes(defaultProjectModelInJson, defaultDomain, 'Project');
  repo.domains.add(defaultDomain);
  repo.gen();
  //repo.gen(specific:false);
}

testData() {
  var repo = new DartlingRepo();
  testCategoryQuestionLinkData(repo, DartlingRepo.categoryQuestionDomainCode,
      DartlingRepo.categoryQuestionLinkModelCode);
  testCategoryQuestionLinkModel();

  testDavidCurtisInstitutionData(repo, DartlingRepo.davidCurtisDomainCode,
      DartlingRepo.davidCurtisInstitutionModelCode);

  testDefaultProjectData(repo, DartlingRepo.defaultDomainCode,
      DartlingRepo.defaultProjectModelCode);
  testDefaultUserData(repo, DartlingRepo.defaultDomainCode,
      DartlingRepo.defaultUserModelCode);

  //lastSingleTest(repo, '', '');
  //lastGroupTest(repo, '', '');
}

void main() {
  genCode();
  testData();
}
