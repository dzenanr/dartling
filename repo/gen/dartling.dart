
var license =
'''
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
''';

String genDartling(Repo repo) {
  var sc = '${license} \n';
  sc = '${sc}// dartling.dart \n';
  sc = '${sc} \n';
  sc = '${sc}#library("dartling"); \n';
  sc = '${sc} \n';
  sc = '${sc}//#import("package:unittest/unittest.dart"); \n';
  sc = '${sc}#import("../unittest/unittest.dart"); \n';
  sc = '${sc}#import("dart:json"); \n';
  sc = '${sc}#import("dart:math"); \n';
  sc = '${sc}#import("dart:uri"); \n';
  sc = '${sc} \n';

  sc = '${sc}#source("../dartling/repo/domain/model/event/actions.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/event/reactions.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/exception/errors.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/exception/exceptions.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/transfer/json.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/entities.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/entity.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/entries.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/id.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/model/oid.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/models.dart"); \n';
  sc = '${sc}#source("../dartling/repo/domain/session.dart"); \n';
  sc = '${sc} \n';

  sc = '${sc}#source("../dartling/repo/gen/dartling.dart"); \n';
  sc = '${sc}#source("../dartling/repo/gen/generated.dart"); \n';
  sc = '${sc}#source("../dartling/repo/gen/specific.dart"); \n';
  sc = '${sc}#source("../dartling/repo/gen/tests.dart"); \n';
  sc = '${sc} \n';

  sc = '${sc}#source("../dartling/repo/meta/attributes.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/children.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/concepts.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/domains.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/models.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/neighbor.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/parents.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/property.dart"); \n';
  sc = '${sc}#source("../dartling/repo/meta/types.dart"); \n';
  sc = '${sc} \n';

  sc = '${sc}#source("../dartling/repo/repository.dart"); \n';
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("repo/code/generated/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
      '${model.codeWithCamelCaseInLowerCaseUnderscore}/entries.dart"); \n';
      for (Concept concept in model.concepts) {
        sc = '${sc}#source("repo/code/generated/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
        '${model.codeWithCamelCaseInLowerCaseUnderscore}/${concept.codeInPlural.toLowerCase()}.'
        'dart"); \n';
      }
    }
    sc = '${sc}#source("repo/code/generated/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
         'models.dart"); \n';
    sc = '${sc}#source("repo/code/generated/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
         'repository.dart"); \n';
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      for (Concept concept in model.concepts) {
        sc = '${sc}#source("repo/code/specific/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
        '${model.codeWithCamelCaseInLowerCaseUnderscore}/${concept.codeInPlural.toLowerCase()}.'
        'dart"); \n';
      }
      sc = '${sc}#source("repo/code/specific/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
      '${model.codeWithCamelCaseInLowerCaseUnderscore}/init.dart"); \n';
    }
  }
  sc = '${sc} \n';
  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("repo/code/specific/tests/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
      '${model.codeWithCamelCaseInLowerCaseUnderscore}/data.dart"); \n';
    }
  }
  sc = '${sc}#source("repo/code/specific/tests/lastgrouptest.dart"); \n';
  sc = '${sc}#source("repo/code/specific/tests/lastsingletest.dart"); \n';
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("repo/data/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
           '${model.codeWithCamelCaseInLowerCaseUnderscore}/json.dart"); \n';
    }
  }
  sc = '${sc} \n';
  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("repo/data/model/${domain.codeWithCamelCaseInLowerCaseUnderscore}/'
           '${model.codeWithCamelCaseInLowerCaseUnderscore}/json.dart"); \n';
    }
  }
  sc = '${sc} \n';

  sc = '${sc}genCode() { \n';
  sc = '${sc}  var repo = new Repo(); \n';
  sc = '${sc} \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}  // change "Dartling" to "YourDomainName" \n';
    sc = '${sc}  var ${domain.codeWithFirstLetterInLowerCase}Domain = '
         'new Domain("${domain.code}"); \n';
    sc = '${sc} \n';
    for (Model model in domain.models) {
      sc = '${sc}  // change dartling to yourDomainName \n';
      sc = '${sc}  // change Skeleton to YourModelName \n';
      sc = '${sc}  // change "Skeleton" to "YourModelName" \n';
      sc = '${sc}  Model ${domain.codeWithFirstLetterInLowerCase}'
           '${model.code}Model = \n';
      sc = '${sc}      fromMagicBoxes(${domain.codeWithFirstLetterInLowerCase}'
           '${model.code}ModelInJson, '
           '${domain.codeWithFirstLetterInLowerCase}'
           'Domain, "${model.code}"); \n';
      sc = '${sc} \n';
    }
    sc = '${sc}  repo.domains.add(${domain.codeWithFirstLetterInLowerCase}'
         'Domain); \n';
    sc = '${sc} \n';
  }
  sc = '${sc}  repo.gen(); \n';
  sc = '${sc}  //repo.gen(specific:false); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}testData() { \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}  var ${domain.codeWithFirstLetterInLowerCase}Repo = '
         'new ${domain.code}Repo(); \n';
    sc = '${sc} \n';
    for (Model model in domain.models) {
      sc = '${sc}  test${domain.code}${model.code}Data('
           '${domain.codeWithFirstLetterInLowerCase}Repo, '
           '${domain.code}Repo.${domain.codeWithFirstLetterInLowerCase}'
           'DomainCode, \n';
      sc = '${sc}      ${domain.code}Repo.'
           '${domain.codeWithFirstLetterInLowerCase}'
           '${model.code}ModelCode); \n';
      sc = '${sc} \n';
    }
  }
  sc = '${sc}  //lastSingleTest(repo, "", ""); \n';
  sc = '${sc}  //lastSingleTest(repo, "", ""); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}initData() { \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}   var ${domain.codeWithFirstLetterInLowerCase}Repo = '
         'new ${domain.code}Repo(); \n';
    sc = '${sc}   var ${domain.codeWithFirstLetterInLowerCase}Models = \n';
    sc = '${sc}       ${domain.codeWithFirstLetterInLowerCase}Repo.'
         'getDomainModels(${domain.code}Repo.'
         '${domain.codeWithFirstLetterInLowerCase}DomainCode); \n';
    sc = '${sc} \n';
    for (Model model in domain.models) {
      sc = '${sc}   var ${domain.codeWithFirstLetterInLowerCase}${model.code}'
           'Entries = \n';
      sc = '${sc}       ${domain.codeWithFirstLetterInLowerCase}Models.'
           'getModelEntries(${domain.code}Repo.'
           '${domain.codeWithFirstLetterInLowerCase}'
           '${model.code}ModelCode); \n';
      sc = '${sc}   init${domain.code}${model.code}('
           '${domain.codeWithFirstLetterInLowerCase}${model.code}'
           'Entries); \n';
      sc = '${sc}   ${domain.codeWithFirstLetterInLowerCase}${model.code}'
           'Entries.display(); \n';
      sc = '${sc}   ${domain.codeWithFirstLetterInLowerCase}${model.code}'
           'Entries.displayJson(); \n';
    }
  }
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  sc = '${sc}  genCode(); \n';
  sc = '${sc}  //testData(); \n';
  sc = '${sc}  //initData(); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}