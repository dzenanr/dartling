

lastSingleTest(Repo repo, String modelCode) {
  test('Test Title', () {
    var models = repo.defaultDomainModels;
    var session = models.newSession();
    var entries = models.getModelEntries(modelCode);


  });
}
