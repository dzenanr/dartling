

lastSingleTest(Repo repo, String modelCode) {
  test('Test Title', () {
    var domainData = repo.defaultDomainModels;
    var session = domainData.newSession();
    var modelData = domainData.getModelEntries(modelCode);


  });
}
