
//#import("package:unittest/unittest.dart");
#import("../../../../unittest/unittest.dart");

#source("../../../lib/data/repository.dart");

// Code template for the last group test.

lastGroupTest(Repo repo, String domainCode, String modelCode) {
  group('Testing ${domainCode}.${modelCode}', () {
    setUp(() {
      var models = repo.getDomainModels(domainCode);
      var session = models.newSession();
      var entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);


    });
    tearDown(() {

    });
    test('Test Title', () {

    });

  });
}
