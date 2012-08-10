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

#source('generated/dc/institution/entries.dart');
#source('generated/dc/institution/ecoles.dart');

#source('generated/default/link/categories.dart');
#source('generated/default/link/entries.dart');
#source('generated/default/link/interests.dart');
#source('generated/default/link/members.dart');
#source('generated/default/link/webLinks.dart');
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

#source('repository/domain/model/event/reactions.dart');
#source('repository/domain/model/event/actions.dart');
#source('repository/domain/model/exception/errors.dart');
#source('repository/domain/model/exception/exceptions.dart');
#source('repository/domain/model/transfer/json.dart');
#source('repository/domain/model/entries.dart');
#source('repository/domain/model/entities.dart');
#source('repository/domain/model/entity.dart');
#source('repository/domain/model/id.dart');
#source('repository/domain/model/oid.dart');
#source('repository/domain/models.dart');
#source('repository/domain/session.dart');
#source('repository/repository.dart');

#source('specific/dc/institution/ecoles.dart');

#source('specific/default/link/categories.dart');
#source('specific/default/link/interests.dart');
#source('specific/default/link/members.dart');
#source('specific/default/link/webLinks.dart');
#source('specific/default/project/projects.dart');
#source('specific/default/user/users.dart');

#source('test/specific/dc/institution/data.dart');
#source('test/specific/default/link/data.dart');
#source('test/specific/default/link/model.dart');
#source('test/specific/default/project/data.dart');
#source('test/specific/default/user/data.dart');
#source('test/lastGroupTest.dart');
#source('test/lastSingleTest.dart');

var repository;

initRepo() {
  var domains = new Domains();
  repository = new Repo(domains);

  var dcDomain = new Domain('dc');
  domains.add(dcDomain);
  var defaultDomain = new Domain();
  domains.add(defaultDomain);

  var dcModels = new DomainModels(dcDomain);
  repository.add(dcModels);
  var defaultModels = new DomainModels(defaultDomain);
  repository.add(defaultModels);
}

void main() {
  initRepo();

  var dcDomain = repository.domains.getDomain('dc');
  var dcModels = repository.getDomainModels('dc');

  var defaultDomain = repository.domains.defaultDomain;
  var defaultModels = repository.defaultDomainModels;

  var institutionModelCode = 'Institution';
  var institutionEntries =
      fromJsonToInstitutionEntries(defaultDomain, institutionModelCode);
  defaultModels.add(institutionEntries);
  testInstitutionData(repository, institutionModelCode);

  var projectModelCode = 'Project';
  var projectEntries = fromJsonToProjectEntries(defaultDomain, projectModelCode);
  defaultModels.add(projectEntries);
  testProjectData(repository, projectModelCode);

  var userModelCode = 'User';
  var userEntries = fromJsonToUserEntries(defaultDomain, userModelCode);
  defaultModels.add(userEntries);
  testUserData(repository, userModelCode);

  var linkModelCode = 'Link';
  var linkEntries = fromJsonToLinkEntries(defaultDomain, linkModelCode);
  defaultModels.add(linkEntries);
  testLinkData(repository, linkModelCode);

  testLinkModel();

  //lastSingleTest();
  //lastGroupTest();
}