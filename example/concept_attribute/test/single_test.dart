
#import("package:unittest/unittest.dart", prefix:"unittest");
//#import("../../../../unittest/unittest.dart");
#import("package:dartling/dartling.dart");
//#source("../../../lib/data/repository.dart");

// Code template for the last single test.

lastSingleTest(Repo repo, String domainCode, String modelCode) {
  test('Single Test for ${domainCode}.${modelCode}', () {
    var models = repo.getDomainModels(domainCode);
    var session = models.newSession();
    var entries = models.getModelEntries(modelCode);
    expect(entries, isNotNull);


  });
}
