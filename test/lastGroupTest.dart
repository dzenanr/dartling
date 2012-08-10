
lastGroupTest(Repo repo, String modelCode) {
  var models;
  var session;
  var entries;
  group('Group Title', () {
    setUp(() {
      models = repo.defaultDomainModels;
      session = models.newSession();
      entries = models.getModelEntries(modelCode);


    });
    tearDown(() {

    });
    test('Test Title', () {

    });

  });
}
