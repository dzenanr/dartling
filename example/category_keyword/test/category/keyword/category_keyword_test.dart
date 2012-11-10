
import 'package:dartling/dartling.dart';
import 'package:unittest/unittest.dart';

// pub
//import 'package:category_keyword/category_keyword.dart';

part '../../../lib/category/keyword/json/data.dart';
part '../../../lib/category/keyword/json/model.dart';
part '../../../lib/category/keyword/init.dart';
part '../../../lib/category/keyword/categories.dart';
part '../../../lib/category/keyword/keywords.dart';
part '../../../lib/category/keyword/tags.dart';
part '../../../lib/gen/category/keyword/entries.dart';
part '../../../lib/gen/category/keyword/categories.dart';
part '../../../lib/gen/category/keyword/keywords.dart';
part '../../../lib/gen/category/keyword/tags.dart';
part '../../../lib/gen/category/models.dart';
part '../../../lib/gen/category/repository.dart';
// pub

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
      entries.categories.display(title:'From JSON to Model: Categories');
      entries.keywords.display(title:'From JSON to Model: Keywords');
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
