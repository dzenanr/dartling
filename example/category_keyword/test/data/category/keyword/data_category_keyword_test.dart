
// test/data/category/keyword/data_category_keyword_test.dart

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

#source("../../../../src/data/category/keyword/json/data.dart");
// do not change model
#source("../../../../src/data/category/keyword/json/model.dart");

#source("../../../../src/data/category/keyword/init.dart");
#source("../../../../src/data/category/keyword/categories.dart");
#source("../../../../src/data/category/keyword/keywords.dart");
#source("../../../../src/data/category/keyword/tags.dart");

#source("../../../../src/data/gen/category/keyword/entries.dart");
#source("../../../../src/data/gen/category/keyword/categories.dart");
#source("../../../../src/data/gen/category/keyword/keywords.dart");
#source("../../../../src/data/gen/category/keyword/tags.dart");
// do not change models
#source("../../../../src/data/gen/category/models.dart");
#source("../../../../src/data/gen/category/repository.dart");

testCategoryKeyword(Repo repo, String domainCode, String modelCode) {
  var models;
  var session;
  var entries;
  group("Testing ${domainCode}.${modelCode}", () {
    setUp(() {
      models = repo.getDomainModels(domainCode);
      session = models.newSession();
      entries = models.getModelEntries(modelCode);
      expect(entries, isNotNull);

      Categories categories = entries.categories;
      Concept categoryConcept = categories.concept;

      Category dartCategory = new Category(categoryConcept);
      dartCategory.nameAndPath = 'Dart';
      categories.add(dartCategory);

      Category learningDartCategory = new Category(categoryConcept);
      learningDartCategory.category = dartCategory;
      learningDartCategory.nameAndPath = 'Learning Dart';
      dartCategory.categories.add(learningDartCategory);

      Category dartCanvasCategory = new Category(categoryConcept);
      dartCanvasCategory.category = dartCategory;
      dartCanvasCategory.nameAndPath = 'Dart Canvas';
      dartCategory.categories.add(dartCanvasCategory);

      Keywords keywords = entries.keywords;
      Concept keywordConcept = keywords.concept;

      Keyword functionKeyword = new Keyword.withId(keywordConcept, 'function');
      keywords.add(functionKeyword);

      Keyword classKeyword = new Keyword.withId(keywordConcept, 'class');
      keywords.add(classKeyword);

      Keyword typeKeyword = new Keyword.withId(keywordConcept, 'type');
      keywords.add(typeKeyword);

      Keyword variableKeyword = new Keyword.withId(keywordConcept, 'variable');
      keywords.add(variableKeyword);

      Concept tagConcept = entries.getConcept('Tag');

      Tag classDartTag = new Tag.withId(tagConcept, classKeyword, dartCategory);
      dartCategory.tags.add(classDartTag);
      classKeyword.tags.add(classDartTag);

      Tag functionDartCanvasTag =
          new Tag.withId(tagConcept, functionKeyword, dartCanvasCategory);
      dartCategory.tags.add(functionDartCanvasTag);
      classKeyword.tags.add(functionDartCanvasTag);
    });
    tearDown(() {
      entries.clear();
    });
    test("Empty Entries Test", () {
      expect(entries.empty, isFalse);
    });
    test('From Model to JSON', () {
      var json = entries.toJson();
      expect(json, isNotNull);
      entries.displayJson();
    });
    test('From JSON to Model', () {
      entries.clear();
      expect(entries.empty, isTrue);
      entries.fromJsonToData();
      entries.categories.display('From JSON to Model: Categories');
      entries.keywords.display('From JSON to Model: Keywords');
    });

  });
}

testCategoryData(CategoryRepo categoryRepo) {
  testCategoryKeyword(categoryRepo, CategoryRepo.categoryDomainCode,
      CategoryRepo.categoryKeywordModelCode);
}

void main() {
  var categoryRepo = new CategoryRepo();
  testCategoryData(categoryRepo);
}
