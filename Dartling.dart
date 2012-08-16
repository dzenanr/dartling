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
#import('dart:math');
#import('dart:uri');

#source('data/categoryQuestion/link/json.dart');
#source('data/davidCurtis/institution/json.dart');
#source('data/default/project/json.dart');
#source('data/default/user/json.dart');

#source('generated/categoryQuestion/link/categories.dart');
#source('generated/categoryQuestion/link/comments.dart');
#source('generated/categoryQuestion/link/entries.dart');
#source('generated/categoryQuestion/link/interests.dart');
#source('generated/categoryQuestion/link/members.dart');
#source('generated/categoryQuestion/link/questions.dart');
#source('generated/categoryQuestion/link/webLinks.dart');

#source('generated/davidCurtis/institution/ecoles.dart');
#source('generated/davidCurtis/institution/entries.dart');

#source('generated/default/project/entries.dart');
#source('generated/default/project/projects.dart');
#source('generated/default/user/entries.dart');
#source('generated/default/user/users.dart');

#source('meta/attributes.dart');
#source('meta/children.dart');
#source('meta/concepts.dart');
#source('meta/domains.dart');
#source('meta/models.dart');
#source('meta/neighbor.dart');
#source('meta/parents.dart');
#source('meta/property.dart');
#source('meta/types.dart');

#source('model/categoryQuestion/link/json.dart');
#source('model/davidCurtis/institution/json.dart');
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

#source('specific/categoryQuestion/link/categories.dart');
#source('specific/categoryQuestion/link/comments.dart');
#source('specific/categoryQuestion/link/interests.dart');
#source('specific/categoryQuestion/link/members.dart');
#source('specific/categoryQuestion/link/questions.dart');
#source('specific/categoryQuestion/link/webLinks.dart');

#source('specific/davidCurtis/institution/ecoles.dart');

#source('specific/default/project/projects.dart');
#source('specific/default/user/users.dart');

#source('test/specific/categoryQuestion/link/data.dart');
#source('test/specific/categoryQuestion/link/model.dart');

#source('test/specific/davidCurtis/institution/data.dart');

#source('test/specific/default/project/data.dart');
#source('test/specific/default/user/data.dart');

#source('test/lastGroupTest.dart');
#source('test/lastSingleTest.dart');

var repository;

initRepo() {
  var domains = new Domains();
  repository = new Repo(domains);

  var categoryQuestionDomain = new Domain('CategoryQuestion');
  domains.add(categoryQuestionDomain);

  var davidCurtisDomain = new Domain('DavidCurtis');
  domains.add(davidCurtisDomain);

  var defaultDomain = new Domain();
  domains.add(defaultDomain);

  var categoryQuestionModels = new DomainModels(categoryQuestionDomain);
  repository.add(categoryQuestionModels);

  var davidCurtisModels = new DomainModels(davidCurtisDomain);
  repository.add(davidCurtisModels);

  var defaultModels = new DomainModels(defaultDomain);
  repository.add(defaultModels);
}

void main() {
  initRepo();

  var categoryQuestionDomainCode = 'CategoryQuestion';
  var categoryQuestionDomain =
      repository.domains.getDomain(categoryQuestionDomainCode);
  var categoryQuestionModels =
      repository.getDomainModels(categoryQuestionDomainCode);

  var davidCurtisDomainCode = 'DavidCurtis';
  var davidCurtisDomain = repository.domains.getDomain(davidCurtisDomainCode);
  var davidCurtisModels = repository.getDomainModels(davidCurtisDomainCode);

  var defaultDomainCode = 'Default';
  var defaultDomain = repository.domains.getDomain(defaultDomainCode);
  var defaultModels = repository.getDomainModels(defaultDomainCode);

  var linkModelCode = 'Link';
  var linkEntries = fromJsonToLinkEntries(categoryQuestionDomain, linkModelCode);
  categoryQuestionModels.add(linkEntries);
  testLinkData(repository, categoryQuestionDomainCode, linkModelCode);

  var institutionModelCode = 'Institution';
  var institutionEntries =
      fromJsonToInstitutionEntries(davidCurtisDomain, institutionModelCode);
  davidCurtisModels.add(institutionEntries);
  testInstitutionData(repository, davidCurtisDomainCode, institutionModelCode);

  var projectModelCode = 'Project';
  var projectEntries = fromJsonToProjectEntries(
      defaultDomain, projectModelCode);
  defaultModels.add(projectEntries);
  testProjectData(repository, projectModelCode);

  var userModelCode = 'User';
  var userEntries = fromJsonToUserEntries(defaultDomain, userModelCode);
  defaultModels.add(userEntries);
  testUserData(repository, userModelCode);

  testLinkModel();

  //lastSingleTest(repository, categoryQuestionDomainCode, linkModelCode);
  //lastGroupTest(repository, categoryQuestionDomainCode, linkModelCode);
}