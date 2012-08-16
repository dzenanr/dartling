
lastSingleTest(Repo repo, String domainCode, String modelCode) {
  test('Single Test for ${domainCode}.${modelCode}', () {
    var models = repo.getDomainModels(domainCode);
    expect(models, isNotNull);
    var session = models.newSession();
    expect(session, isNotNull);
    var entries = models.getModelEntries(modelCode);
    expect(entries, isNotNull);


  });
}
