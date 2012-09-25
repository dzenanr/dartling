
// test/data/art/pen/data_art_pen_test.dart

//#import("package:unittest/unittest.dart");
#import("../../../../../../../unittest/unittest.dart");
#import("dart:json");
#import("dart:math");
#import("dart:uri");

//#import("package:dartling/dartling.dart");
#source("../../../../../../lib/data/domain/model/event/actions.dart");
#source("../../../../../../lib/data/domain/model/event/reactions.dart");
#source("../../../../../../lib/data/domain/model/exception/errors.dart");
#source("../../../../../../lib/data/domain/model/exception/exceptions.dart");
#source("../../../../../../lib/data/domain/model/transfer/json.dart");
#source("../../../../../../lib/data/domain/model/entities.dart");
#source("../../../../../../lib/data/domain/model/entity.dart");
#source("../../../../../../lib/data/domain/model/entries.dart");
#source("../../../../../../lib/data/domain/model/id.dart");
#source("../../../../../../lib/data/domain/model/oid.dart");
#source("../../../../../../lib/data/domain/models.dart");
#source("../../../../../../lib/data/domain/session.dart");

#source("../../../../../../lib/data/gen/dartling_data.dart");
#source("../../../../../../lib/data/gen/dartling_view.dart");
#source("../../../../../../lib/data/gen/generated.dart");
#source("../../../../../../lib/data/gen/specific.dart");
#source("../../../../../../lib/data/gen/tests.dart");

#source("../../../../../../lib/data/meta/attributes.dart");
#source("../../../../../../lib/data/meta/children.dart");
#source("../../../../../../lib/data/meta/concepts.dart");
#source("../../../../../../lib/data/meta/domains.dart");
#source("../../../../../../lib/data/meta/models.dart");
#source("../../../../../../lib/data/meta/neighbor.dart");
#source("../../../../../../lib/data/meta/parents.dart");
#source("../../../../../../lib/data/meta/property.dart");
#source("../../../../../../lib/data/meta/types.dart");

#source("../../../../../../lib/data/repository.dart");

#source("../../../../src/data/art/pen/json/data.dart");
#source("../../../../src/data/art/pen/json/model.dart");

#source("../../../../src/data/art/pen/init.dart");
#source("../../../../src/data/art/pen/segments.dart");
#source("../../../../src/data/art/pen/lines.dart");

#source("../../../../src/data/gen/art/pen/entries.dart");
#source("../../../../src/data/gen/art/pen/segments.dart");
#source("../../../../src/data/gen/art/pen/lines.dart");
#source("../../../../src/data/gen/art/models.dart");
#source("../../../../src/data/gen/art/repository.dart");

testArtPen(Repo repo, String domainCode, String modelCode) {
  var models;
  var session;
  var entries;
  group("Testing ${domainCode}.${modelCode}", () {
    setUp(() {
      models = repo.getDomainModels(domainCode);
      session = models.newSession();
      entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);


    });
    tearDown(() {
      entries.clear();
    });
    test("Empty Entries Test", () {
      expect(entries.empty, isTrue);
    });

  });
}

testArtData(ArtRepo artRepo) {
  testArtPen(artRepo, ArtRepo.artDomainCode,
      ArtRepo.artPenModelCode);
}

void main() {
  var artRepo = new ArtRepo();
  testArtData(artRepo);
}
