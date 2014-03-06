part of dartling;

String genDartlingGen(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// test/${domain.codeLowerUnderscore}/${model.codeLowerUnderscore}/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}_gen.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}genCode(Repository repository) { \n';
  sc = '${sc}  repository.gen("${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}"); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}initData(Repository repository) { \n';
  sc = '${sc}   var ${domain.codeFirstLetterLower}Domain = '
       'repository.getDomainModels(${domain.code}); \n';
  sc = '${sc}   var ${model.codeFirstLetterLower}Model = '
       '${domain.codeFirstLetterLower}Domain.'
       'getModelEntries(${model.code}); \n';
  sc = '${sc}   ${model.codeFirstLetterLower}Model.init(); \n';
  sc = '${sc}   //${model.codeFirstLetterLower}Model.display(); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';
  
  sc = '${sc}void main() { \n';
  sc = '${sc}  var repository = new Repository(); \n';
  sc = '${sc}  genCode(repository); \n';
  sc = '${sc}  //initData(repository); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genDartlingTest(Repo repo, Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// test/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}_test.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:unittest/unittest.dart"; \n';
  sc = '${sc}import "package:dartling/dartling.dart"; \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}test${domain.code}${model.code}('
       'Repository repository, String domainCode, String modelCode) { \n';
  sc = '${sc}  var domain; \n';
  sc = '${sc}  var session; \n';
  sc = '${sc}  var model; \n';
  sc = '${sc}  group("Testing \${domainCode}.\${modelCode}", () { \n';
  sc = '${sc}    setUp(() { \n';
  sc = '${sc}      domain = repository.getDomainModels(domainCode); \n';
  sc = '${sc}      session = domain.newSession(); \n';
  sc = '${sc}      model = domain.getModelEntries(modelCode); \n';
  sc = '${sc}      expect(model, isNotNull); \n';
  sc = '${sc}      model.init(); \n';
  sc = '${sc}    }); \n';
  sc = '${sc}    tearDown(() { \n';
  sc = '${sc}      model.clear(); \n';
  sc = '${sc}      expect(model.isEmpty, isTrue); \n';
  sc = '${sc}    }); \n';
  sc = '${sc}    test("Not empty model", () { \n';
  sc = '${sc}      expect(model.isEmpty, isFalse); \n';
  sc = '${sc}    }); \n';
  sc = '${sc} \n';
  sc = '${sc}  }); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  sc = '${sc}  test${domain.code}${model.code}('
       'new Repository(), ${domain.code}, ${model.code}); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

