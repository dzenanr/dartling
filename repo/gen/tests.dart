
String genTestData(String domain, String model) {
  var sc = ' \n';
  sc = '${sc}// repo/code/specific/tests/${domain.toLowerCase()}/'
       '${model.toLowerCase()}/dart.dart \n';
  sc = '${sc} \n';
  sc = '${sc}test${domain}${model}Data('
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

  return sc;
}

