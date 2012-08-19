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

#source('data/category_question/link/json.dart');
#source('data/david_curtis/institution/json.dart');
#source('data/default/project/json.dart');
#source('data/default/user/json.dart');

#source('generated/category_question/link/categories.dart');
#source('generated/category_question/link/comments.dart');
#source('generated/category_question/link/entries.dart');
#source('generated/category_question/link/interests.dart');
#source('generated/category_question/link/members.dart');
#source('generated/category_question/link/questions.dart');
#source('generated/category_question/link/webLinks.dart');
#source('generated/category_question/models.dart');
#source('generated/repository.dart');

#source('generated/david_curtis/institution/ecoles.dart');
#source('generated/david_curtis/institution/entries.dart');
#source('generated/david_curtis/models.dart');

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

#source('model/category_question/link/json.dart');
#source('model/david_curtis/institution/json.dart');
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
#source('repository/repository.dart');

#source('specific/category_question/link/categories.dart');
#source('specific/category_question/link/comments.dart');
#source('specific/category_question/link/interests.dart');
#source('specific/category_question/link/members.dart');
#source('specific/category_question/link/questions.dart');
#source('specific/category_question/link/webLinks.dart');

#source('specific/david_curtis/institution/ecoles.dart');

#source('specific/default/project/projects.dart');
#source('specific/default/user/users.dart');

#source('test/category_question/link/data.dart');
#source('test/category_question/link/model.dart');

#source('test/david_curtis/institution/data.dart');

#source('test/default/project/data.dart');
#source('test/default/user/data.dart');

#source('test/last_group_test.dart');
#source('test/last_single_test.dart');

void main() {
  var repo = new DartlingRepo();

  testLinkData(repo, DartlingRepo.categoryQuestionDomainCode,
      DartlingRepo.categoryQuestionLinkModelCode);
  testLinkModel();

  testInstitutionData(repo, DartlingRepo.davidCurtisDomainCode,
      DartlingRepo.davidCurtisInstitutionModelCode);

  testProjectData(repo, DartlingRepo.defaultProjectModelCode);
  testUserData(repo, DartlingRepo.defaultUserModelCode);

  //lastSingleTest(repo, '', '');
  //lastGroupTest(repo, '', '');
}