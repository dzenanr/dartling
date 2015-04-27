import "package:test/test.dart";
import 'category_keyword.dart'; 
 
testCategoryKeywordKeyword( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var model; 
  var keywords; 
  group("Testing Category.Keyword.Keyword", () { 
    domain = repository.getDomainModels(domainCode); 
    model = domain.getModelEntries(modelCode); 
    keywords = model.keywords; 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(model.isEmpty, isFalse); 
      expect(keywords.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      model.clear(); 
      expect(model.isEmpty, isTrue); 
      expect(keywords.isEmpty, isTrue); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = model.fromEntryToJson("Keyword"); 
      expect(json, isNotNull); 
 
      print(json); 
      //model.displayEntryJson("Keyword"); 
      //model.displayJson(); 
      //model.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = model.fromEntryToJson("Keyword"); 
      keywords.clear(); 
      expect(keywords.isEmpty, isTrue); 
      model.fromJsonToEntry(json); 
      expect(keywords.isEmpty, isFalse); 
 
      keywords.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add keyword required error", () { 
      // no required attribute that is not an id 
    }); 
 
    test("Add keyword unique error", () { 
      var keywordConcept = keywords.concept; 
      var keywordCount = keywords.length; 
      var keyword = new Keyword(keywordConcept); 
      var randomKeyword = keywords.random(); 
      keyword.word = randomKeyword.word; 
      var added = keywords.add(keyword); 
      expect(added, isFalse); 
      expect(keywords.length, equals(keywordCount)); 
      expect(keywords.errors.length, greaterThan(0)); 
 
      keywords.errors.display(title: "Add keyword unique error"); 
    }); 
 
      // Find keyword by required attribute: 
      // no required attribute that is not an id 
 
      // Select keywords by required attribute: 
      // no required attribute that is not an id 
 
    test("Sort keywords", () { 
      keywords.sort(); 
 
      //keywords.display(title: "Sort keywords"); 
    }); 
 
    test("Order keywords", () { 
      var orderedKeywords = keywords.order(); 
      expect(orderedKeywords.isEmpty, isFalse); 
      expect(orderedKeywords.length, equals(keywords.length)); 
      expect(orderedKeywords.source.isEmpty, isFalse); 
      expect(orderedKeywords.source.length, equals(keywords.length)); 
      expect(orderedKeywords, isNot(same(keywords))); 
 
      //orderedKeywords.display(title: "Order keywords"); 
    }); 
 
    test("Copy keywords", () { 
      var copiedKeywords = keywords.copy(); 
      expect(copiedKeywords.isEmpty, isFalse); 
      expect(copiedKeywords.length, equals(keywords.length)); 
      expect(copiedKeywords, isNot(same(keywords))); 
      copiedKeywords.forEach((e) => 
        expect(e, equals(keywords.singleWhereOid(e.oid)))); 
      copiedKeywords.forEach((e) => 
        expect(e, isNot(same(keywords.singleWhereId(e.id))))); 
 
      //copiedKeywords.display(title: "Copy keywords"); 
    }); 
 
    test("True for every keyword", () { 
      // no required attribute that is not an id 
    }); 
 
    test("Random keyword", () { 
      var keyword1 = keywords.random(); 
      expect(keyword1, isNotNull); 
      var keyword2 = keywords.random(); 
      expect(keyword2, isNotNull); 
 
      //keyword1.display(prefix: "random1"); 
      //keyword2.display(prefix: "random2"); 
    }); 
 
  }); 
} 
 
void main() { 
  testCategoryKeywordKeyword(new Repository(), "Category", "Keyword"); 
} 
 
