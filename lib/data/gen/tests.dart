
String genTestData(String place, Repo repo, Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// test/data/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/data_${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}_test.dart \n';
  sc = '${sc} \n';
  if (place == 'pub') {
    sc = '${sc}#import("package:unittest/unittest.dart"); \n';
  } else if (place == 'child') {
    sc = '${sc}#import("../../../../../../../unittest/unittest.dart"); \n';
  } else { // twin
    sc = '${sc}#import("../../../../../unittest/unittest.dart"); \n';
  }
  sc = '${sc}#import("dart:json"); \n';
  sc = '${sc}#import("dart:math"); \n';
  sc = '${sc}#import("dart:uri"); \n';
  sc = '${sc} \n';

  if (place == 'pub') {
    sc = '${sc}#import("package:dartling/dartling.dart"); \n';
  } else if (place == 'child') {
    sc = '${sc}#source("../../../../../../lib/data/domain/model/event/actions.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/event/reactions.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/exception/errors.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/exception/exceptions.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/transfer/json.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/entities.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/entity.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/entries.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/id.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/model/oid.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/models.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/domain/session.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../../../../lib/data/gen/dartling_data.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/gen/dartling_view.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/gen/generated.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/gen/specific.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/gen/tests.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../../../../lib/data/meta/attributes.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/children.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/concepts.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/domains.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/models.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/neighbor.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/parents.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/property.dart"); \n';
    sc = '${sc}#source("../../../../../../lib/data/meta/types.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../../../../lib/data/repository.dart"); \n';
  } else { // twin
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/event/actions.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/event/reactions.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/exception/errors.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/exception/exceptions.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/transfer/json.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/entities.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/entity.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/entries.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/id.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/model/oid.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/models.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/domain/session.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../../../dartling/lib/data/gen/dartling_data.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/gen/dartling_view.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/gen/generated.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/gen/specific.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/gen/tests.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../../../dartling/lib/data/meta/attributes.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/children.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/concepts.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/domains.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/models.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/neighbor.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/parents.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/property.dart"); \n';
    sc = '${sc}#source("../../../../../dartling/lib/data/meta/types.dart"); \n';
    sc = '${sc} \n';

    sc = '${sc}#source("../../../../../dartling/lib/data/repository.dart"); \n';
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("../../../../src/data/${domain.codeLowerUnderscore}/'
           '${model.codeLowerUnderscore}/json/data.dart"); \n';
    }
  }
  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("../../../../src/data/${domain.codeLowerUnderscore}/'
           '${model.codeLowerUnderscore}/json/model.dart"); \n';
    }
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("../../../../src/data/${domain.codeLowerUnderscore}/'
      '${model.codeLowerUnderscore}/init.dart"); \n';
      for (Concept concept in model.concepts) {
        sc = '${sc}#source("../../../../src/data/${domain.codeLowerUnderscore}/'
        '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart"); \n';
      }
    }
  }
  sc = '${sc} \n';

  for (Domain domain in repo.domains) {
    for (Model model in domain.models) {
      sc = '${sc}#source("../../../../src/data/gen/${domain.codeLowerUnderscore}/'
      '${model.codeLowerUnderscore}/entries.dart"); \n';
      for (Concept concept in model.concepts) {
        sc = '${sc}#source("../../../../src/data/gen/${domain.codeLowerUnderscore}/'
        '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart"); \n';
      }
    }
    sc = '${sc}#source("../../../../src/data/gen/${domain.codeLowerUnderscore}/'
         'models.dart"); \n';
    sc = '${sc}#source("../../../../src/data/gen/${domain.codeLowerUnderscore}/'
         'repository.dart"); \n';
  }
  sc = '${sc} \n';

  sc = '${sc}test${domain.code}${model.code}('
       'Repo repo, String domainCode, String modelCode) { \n';
  sc = '${sc}  var models; \n';
  sc = '${sc}  var session; \n';
  sc = '${sc}  var entries; \n';
  sc = '${sc}  group("Testing \${domainCode}.\${modelCode}", () { \n';
  sc = '${sc}    setUp(() { \n';
  sc = '${sc}      models = repo.getDomainModels(domainCode); \n';
  sc = '${sc}      session = models.newSession(); \n';
  sc = '${sc}      entries = models.getModelEntries(modelCode); \n';
  sc = '${sc}      expect(entries, isNotNull); \n';
  sc = '${sc} \n';
  sc = '${sc} \n';
  sc = '${sc}    }); \n';
  sc = '${sc}    tearDown(() { \n';
  sc = '${sc}      entries.clear(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc}    test("Empty Entries Test", () { \n';
  sc = '${sc}      expect(entries.empty, isTrue); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  sc = '${sc}  }); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}test${domain.code}Data(${domain.code}Repo '
       '${domain.codeFirstLetterLower}Repo) { \n';
  sc = '${sc}  test${domain.code}${model.code}(${domain.codeFirstLetterLower}'
       'Repo, ${domain.code}Repo.${domain.codeFirstLetterLower}DomainCode, \n';
  sc = '${sc}      ${domain.code}Repo.${domain.codeFirstLetterLower}'
       '${model.code}ModelCode); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  sc = '${sc}  var ${domain.codeFirstLetterLower}Repo = '
       'new ${domain.code}Repo(); \n';
  sc = '${sc}  test${domain.code}Data(${domain.codeFirstLetterLower}Repo); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

