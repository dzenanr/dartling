


lastSingleTest(Repo repo, String domainCode, String modelCode) {
  test('Single Test for ${domainCode}.${modelCode}', () {
    var models = repo.getDomainModels(domainCode);
    var session = models.newSession();
    var entries = models.getModelEntries(modelCode);


  });
}
