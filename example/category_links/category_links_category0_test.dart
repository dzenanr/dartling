import "package:test/test.dart";
import 'category_links.dart';
 
void testCategoryLinksCategory( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var model; 
  var categories; 
  group("Testing Category.Links.Category", () { 
    domain = repository.getDomainModels(domainCode); 
    model = domain.getModelEntries(modelCode); 
    categories = model.categories; 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(model.isEmpty, isFalse); 
      expect(categories.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      model.clear(); 
      expect(model.isEmpty, isTrue); 
      expect(categories.isEmpty, isTrue); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = model.fromEntryToJson("Category"); 
      expect(json, isNotNull); 
 
      print(json); 
      //model.displayEntryJson("Category"); 
      //model.displayJson(); 
      //model.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = model.fromEntryToJson("Category"); 
      categories.clear(); 
      expect(categories.isEmpty, isTrue); 
      model.fromJsonToEntry(json); 
      expect(categories.isEmpty, isFalse); 
 
      categories.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add category required error", () { 
      var categoryConcept = categories.concept; 
      var categoryCount = categories.length; 
      var category = new Category(categoryConcept); 
      var added = categories.add(category); 
      expect(added, isFalse); 
      expect(categories.length, equals(categoryCount)); 
      expect(categories.errors.length, greaterThan(0)); 
      expect(categories.errors.toList()[0].category, equals("required")); 
 
      categories.errors.display(title: "Add category required error"); 
    }); 
 
    test("Add category unique error", () { 
      var categoryConcept = categories.concept; 
      var categoryCount = categories.length; 
      var category = new Category(categoryConcept); 
      var randomCategory = categories.random(); 
      category.name = randomCategory.name; 
      var added = categories.add(category); 
      expect(added, isFalse); 
      expect(categories.length, equals(categoryCount)); 
      expect(categories.errors.length, greaterThan(0)); 
 
      categories.errors.display(title: "Add category unique error"); 
    }); 
 
    test("Find category by approved", () { 
      var randomCategory = categories.random(); 
      var categoryApproved = randomCategory.approved; 
      Category category = categories.firstWhereAttribute("approved", categoryApproved); 
      expect(category, isNotNull); 
    }); 
 
    test("Select categories by approved", () { 
      var randomCategory = categories.random(); 
      var categoryApproved = randomCategory.approved; 
      var selectedCategories = categories.selectWhereAttribute("approved", categoryApproved); 
      expect(selectedCategories.isEmpty, isFalse); 
 
      //selectedCategories.display(title: "Select categories by approved"); 
    }); 
 
    test("Sort categories", () { 
      categories.sort(); 
 
      //categories.display(title: "Sort categories"); 
    }); 
 
    test("Order categories", () { 
      var orderedCategories = categories.order(); 
      expect(orderedCategories.isEmpty, isFalse); 
      expect(orderedCategories.length, equals(categories.length)); 
      expect(orderedCategories.source.isEmpty, isFalse); 
      expect(orderedCategories.source.length, equals(categories.length)); 
      expect(orderedCategories, isNot(same(categories))); 
 
      //orderedCategories.display(title: "Order categories"); 
    }); 
 
    test("Copy categories", () { 
      var copiedCategories = categories.copy(); 
      expect(copiedCategories.isEmpty, isFalse); 
      expect(copiedCategories.length, equals(categories.length)); 
      expect(copiedCategories, isNot(same(categories))); 
      copiedCategories.forEach((e) => 
        expect(e, equals(categories.singleWhereOid(e.oid)))); 
      copiedCategories.forEach((e) => 
        expect(e, isNot(same(categories.singleWhereId(e.id))))); 
 
      //copiedCategories.display(title: "Copy categories"); 
    }); 
 
    test("True for every category", () { 
      expect(categories.every((e) => e.approved != null), isTrue); 
    }); 
 
    test("Random category", () { 
      var category1 = categories.random(); 
      expect(category1, isNotNull); 
      var category2 = categories.random(); 
      expect(category2, isNotNull); 
 
      //category1.display(prefix: "random1"); 
      //category2.display(prefix: "random2"); 
    }); 
 
  }); 
} 
 
void main() { 
  testCategoryLinksCategory(new Repository(), "Category", "Links"); 
} 
 
