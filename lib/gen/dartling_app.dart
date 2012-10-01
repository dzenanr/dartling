
String genDartlingView(String place, Repo repo) {
  var sc = ' \n';
  sc = '${sc}// dartling_view.dart \n';
  sc = '${sc} \n';
  sc = '${sc}${license} \n';
  if (place == 'pub') {
    sc = '${sc}#import("package:unittest/unittest.dart", prefix:"unittest"); \n';
  } else if (place == 'child') {
    sc = '${sc}#import("../../../../unittest/unittest.dart"); \n';
  } else { // twin
    sc = '${sc}#import("../../unittest/unittest.dart"); \n';
  }
  sc = '${sc}#import("dart:html"); \n';
  sc = '${sc}#import("dart:json"); \n';
  sc = '${sc}#import("dart:math"); \n';
  sc = '${sc}#import("dart:uri"); \n';
  sc = '${sc} \n';

  if (place == 'pub') {
    sc = '${sc}#import("package:dartling/dartling.dart"); \n';
  } else if (place == 'child') {
    sc = '${sc}#source("../../../lib/data/domain/model/event/actions.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/event/reactions.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/exception/errors.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/exception/exceptions.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/transfer/json.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/entities.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/entity.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/entries.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/id.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/model/oid.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/models.dart"); \n';
    sc = '${sc}#source("../../../lib/data/domain/session.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../lib/data/gen/dartling_data.dart"); \n';
    sc = '${sc}#source("../../../lib/data/gen/dartling_view.dart"); \n';
    sc = '${sc}#source("../../../lib/data/gen/generated.dart"); \n';
    sc = '${sc}#source("../../../lib/data/gen/specific.dart"); \n';
    sc = '${sc}#source("../../../lib/data/gen/tests.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../lib/data/meta/attributes.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/children.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/concepts.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/domains.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/models.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/neighbor.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/parents.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/property.dart"); \n';
    sc = '${sc}#source("../../../lib/data/meta/types.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../lib/data/repository.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../lib/view/component/entities.dart"); \n';
    sc = '${sc}#source("../../../lib/view/component/entity.dart"); \n';
    sc = '${sc}#source("../../../lib/view/component/param.dart"); \n';
    sc = '${sc}#source("../../../lib/view/component/repo.dart"); \n';
  } else { // twin
    sc = '${sc}#source("../../dartling/lib/data/domain/model/event/actions.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/event/reactions.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/exception/errors.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/exception/exceptions.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/transfer/json.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/entities.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/entity.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/entries.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/id.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/model/oid.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/models.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/domain/session.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../dartling/lib/data/gen/dartling_data.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/gen/dartling_view.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/gen/generated.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/gen/specific.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/gen/tests.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../dartling/lib/data/meta/attributes.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/children.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/concepts.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/domains.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/models.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/neighbor.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/parents.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/property.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/data/meta/types.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../dartling/lib/data/repository.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../dartling/lib/view/component/entities.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/view/component/entity.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/view/component/param.dart"); \n';
    sc = '${sc}#source("../../dartling/lib/view/component/repo.dart"); \n';
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("data/${domain.codeLowerUnderscore}/'
           '${model.codeLowerUnderscore}/json/data.dart"); \n';
    }
  }
  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("data/${domain.codeLowerUnderscore}/'
           '${model.codeLowerUnderscore}/json/model.dart"); \n';
    }
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("data/${domain.codeLowerUnderscore}/'
      '${model.codeLowerUnderscore}/init.dart"); \n';
      for (Concept concept in model.concepts) {
        sc = '${sc}#source("data/${domain.codeLowerUnderscore}/'
        '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart"); \n';
      }
    }
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("data/gen/${domain.codeLowerUnderscore}/'
      '${model.codeLowerUnderscore}/entries.dart"); \n';
      for (Concept concept in model.concepts) {
        sc = '${sc}#source("data/gen/${domain.codeLowerUnderscore}/'
        '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart"); \n';
      }
    }
    sc = '${sc}#source("data/gen/${domain.codeLowerUnderscore}/'
         'models.dart"); \n';
    sc = '${sc}#source("data/gen/${domain.codeLowerUnderscore}/'
         'repository.dart"); \n';
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    sc = '${sc}init${domain.code}Data(${domain.code}Repo '
         '${domain.codeFirstLetterLower}Repo) { \n';
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
    sc = '${sc}} \n';
    sc = '${sc} \n';
  }

  for (Domain domain in repo.domains) {
    sc = '${sc}show${domain.code}Data(${domain.code}Repo '
         '${domain.codeFirstLetterLower}Repo) { \n';
    sc = '${sc}   var mainView = new View(document, "main"); \n';
    sc = '${sc}   mainView.repo = ${domain.codeFirstLetterLower}Repo; \n';
    sc = '${sc}   new RepoMainSection(mainView); \n';
    sc = '${sc}} \n';
    sc = '${sc} \n';
  }

  sc = '${sc}void main() { \n';
  for (Domain domain in repo.domains) {
    sc = '${sc}  var ${domain.codeFirstLetterLower}Repo = '
    'new ${domain.code}Repo(); \n';
    sc = '${sc}  init${domain.code}Data(${domain.codeFirstLetterLower}Repo); \n';
    sc = '${sc}  show${domain.code}Data(${domain.codeFirstLetterLower}Repo); \n';
  }
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}
