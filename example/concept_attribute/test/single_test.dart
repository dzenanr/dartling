
//#import("package:unittest/unittest.dart");
#import("../../../../unittest/unittest.dart");

#source("../../../lib/data/repository.dart");

// Code template for the last single test.

lastSingleTest(Repo repo, String domainCode, String modelCode) {
  test('Single Test for ${domainCode}.${modelCode}', () {
    var models = repo.getDomainModels(domainCode);
    var session = models.newSession();
    var entries = models.getModelEntries(modelCode);
    expect(entries, isNotNull);


  });
}
