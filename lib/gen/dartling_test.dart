part of dartling;

String genDartlingTest(Repo repo, Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// test/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}_test.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:unittest/unittest.dart"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:dartling/dartling.dart"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
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
  sc = '${sc}      expect(entries.isEmpty, isTrue); \n';
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

