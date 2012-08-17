
lastSingleTest(Repo repo, String domainCode, String modelCode) {
  test('Single Test for ${domainCode}.${modelCode}', () {
    var models = repo.getDomainModels(domainCode);
    expect(models, isNotNull);
    var session = models.newSession();
    expect(session, isNotNull);
    var entries = models.getModelEntries(modelCode);
    expect(entries, isNotNull);

    var projects = entries.projects;
    var projectCount = 0;

    var marketing = new Project.withId(projects.concept, 'Dartling Marketing');
    expect(marketing, isNotNull);
    marketing.description = 'Making Dartling known to the Dart community.';
    projects.add(marketing);
    expect(projects.count, equals(++projectCount));

    marketing.display('before copy: ');
    var afterUpdateMarketing = marketing.copy();
    afterUpdateMarketing.display('after copy: ');
    expect(marketing.oid, equals(afterUpdateMarketing.oid));
    expect(marketing.code, equals(afterUpdateMarketing.code));
    expect(marketing.name, equals(afterUpdateMarketing.name));
    expect(marketing.description, equals(afterUpdateMarketing.description));

    Id marketingId = marketing.id;
    marketingId.display('marketingId');
    Id afterUpdateMarketingId = afterUpdateMarketing.id;
    marketingId.display('afterUpdateMarketingId');
    if (marketingId.equals(afterUpdateMarketingId)) {
      print('==');
    } else {
      print('!=');
    }

    expect(marketing.id, equals(afterUpdateMarketing.id));
  });
}
