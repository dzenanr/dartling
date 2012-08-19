
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
