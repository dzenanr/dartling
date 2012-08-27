

String genApp(Repo repo) {
  var sc = '${license} \n';
  sc = '${sc}// app.dart \n';
  sc = '${sc} \n';
  sc = '${sc}//#import("package:unittest/unittest.dart"); \n';
  sc = '${sc}#import("../unittest/unittest.dart"); \n';
  sc = '${sc}#import("dart:html"); \n';
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

  sc = '${sc}#source("../dartling/repo/gen/app.dart"); \n';
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
      sc = '${sc}#source("repo/code/generated/${domain.codeLowerUnderscore}/'
      '${model.codeLowerUnderscore}/entries.dart"); \n';
      for (Concept concept in model.concepts) {
        var codesLowerUnderscore = concept.codesLowerUnderscore;
        if (codesLowerUnderscore == null) {
          codesLowerUnderscore = concept.codePluralLowerUnderscore;
        }
        sc = '${sc}#source("repo/code/generated/${domain.codeLowerUnderscore}/'
        '${model.codeLowerUnderscore}/${codesLowerUnderscore}.dart"); \n';
      }
    }
    sc = '${sc}#source("repo/code/generated/${domain.codeLowerUnderscore}/'
         'models.dart"); \n';
    sc = '${sc}#source("repo/code/generated/${domain.codeLowerUnderscore}/'
         'repository.dart"); \n';
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      for (Concept concept in model.concepts) {
        var codesLowerUnderscore = concept.codesLowerUnderscore;
        if (codesLowerUnderscore == null) {
          codesLowerUnderscore = concept.codePluralLowerUnderscore;
        }
        sc = '${sc}#source("repo/code/specific/${domain.codeLowerUnderscore}/'
        '${model.codeLowerUnderscore}/${codesLowerUnderscore}.dart"); \n';
      }
      sc = '${sc}#source("repo/code/specific/${domain.codeLowerUnderscore}/'
      '${model.codeLowerUnderscore}/init.dart"); \n';
    }
  }
  sc = '${sc} \n';
  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("repo/code/specific/test/${domain.codeLowerUnderscore}/'
      '${model.codeLowerUnderscore}/data.dart"); \n';
    }
  }
  sc = '${sc}#source("repo/code/specific/test/group.dart"); \n';
  sc = '${sc}#source("repo/code/specific/test/single.dart"); \n';
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("repo/data/${domain.codeLowerUnderscore}/'
           '${model.codeLowerUnderscore}/json.dart"); \n';
    }
  }
  sc = '${sc} \n';
  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("repo/data/model/${domain.codeLowerUnderscore}/'
           '${model.codeLowerUnderscore}/json.dart"); \n';
    }
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    sc = '${sc}initData(${domain.code}Repo ${domain.codeFirstLetterLower}Repo) { \n';
    sc = '${sc}   var ${domain.codeFirstLetterLower}Models = \n';
    sc = '${sc}       ${domain.codeFirstLetterLower}Repo.'
         'getDomainModels(${domain.code}Repo.'
         '${domain.codeFirstLetterLower}DomainCode); \n';
    sc = '${sc} \n';
    for (Model model in domain.models) {
      sc = '${sc}   var ${domain.codeFirstLetterLower}${model.code}'
           'Entries = \n';
      sc = '${sc}       ${domain.codeFirstLetterLower}Models.'
           'getModelEntries(${domain.code}Repo.'
           '${domain.codeFirstLetterLower}'
           '${model.code}ModelCode); \n';
      sc = '${sc}   init${domain.code}${model.code}('
           '${domain.codeFirstLetterLower}${model.code}'
           'Entries); \n';
      sc = '${sc}   ${domain.codeFirstLetterLower}${model.code}'
           'Entries.display(); \n';
      sc = '${sc}   ${domain.codeFirstLetterLower}${model.code}'
           'Entries.displayJson(); \n';
    }
  }
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}  var ${domain.codeFirstLetterLower}Repo = '
    'new ${domain.code}Repo(); \n';
    sc = '${sc}  initData(${domain.codeFirstLetterLower}Repo); \n';
    sc = '${sc} \n';
    sc = '${sc}  // Get a reference to the canvas. \n';
    sc = '${sc}  // CanvasElement canvas = document.query("#canvas"); \n';
    sc = '${sc}  // Board board = new Board(canvas, '
         '${domain.codeFirstLetterLower}Repo); \n';
  }
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}