import "package:test/test.dart";
import 'category_links.dart';
 
void testCategoryLinksComment( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var model; 
  var comments; 
  group("Testing Category.Links.Comment", () { 
    domain = repository.getDomainModels(domainCode); 
    model = domain.getModelEntries(modelCode); 
    comments = model.comments; 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(model.isEmpty, isFalse); 
      expect(comments.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      model.clear(); 
      expect(model.isEmpty, isTrue); 
      expect(comments.isEmpty, isTrue); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = model.fromEntryToJson("Comment"); 
      expect(json, isNotNull); 
 
      print(json); 
      //model.displayEntryJson("Comment"); 
      //model.displayJson(); 
      //model.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = model.fromEntryToJson("Comment"); 
      comments.clear(); 
      expect(comments.isEmpty, isTrue); 
      model.fromJsonToEntry(json); 
      expect(comments.isEmpty, isFalse); 
 
      comments.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add comment required error", () { 
      var commentConcept = comments.concept; 
      var commentCount = comments.length; 
      var comment = new Comment(commentConcept); 
      var added = comments.add(comment); 
      expect(added, isFalse); 
      expect(comments.length, equals(commentCount)); 
      expect(comments.errors.length, greaterThan(0)); 
      expect(comments.errors.toList()[0].category, equals("required")); 
 
      comments.errors.display(title: "Add comment required error"); 
    }); 
 
    test("Add comment unique error", () { 
      // no id attribute 
    }); 
 
    test("Find comment by text", () { 
      var randomComment = comments.random(); 
      var commentText = randomComment.text; 
      Comment comment = comments.firstWhereAttribute("text", commentText); 
      expect(comment, isNotNull); 
    }); 
 
    test("Select comments by text", () { 
      var randomComment = comments.random(); 
      var commentText = randomComment.text; 
      var selectedComments = comments.selectWhereAttribute("text", commentText); 
      expect(selectedComments.isEmpty, isFalse); 
 
      //selectedComments.display(title: "Select comments by text"); 
    }); 
 
    test("Sort comments", () { 
      // no id attribute 
      // add compareTo method in the specific Comment class 
      /* 
      comments.sort(); 
 
      //comments.display(title: "Sort comments"); 
      */ 
    }); 
 
    test("Order comments", () { 
      // no id attribute 
      // add compareTo method in the specific Comment class 
      /* 
      var orderedComments = comments.order(); 
      expect(orderedComments.isEmpty, isFalse); 
      expect(orderedComments.length, equals(comments.length)); 
      expect(orderedComments.source.isEmpty, isFalse); 
      expect(orderedComments.source.length, equals(comments.length)); 
      expect(orderedComments, isNot(same(comments))); 
 
      //orderedComments.display(title: "Order comments"); 
      */ 
    }); 
 
    test("Copy comments", () { 
      var copiedComments = comments.copy(); 
      expect(copiedComments.isEmpty, isFalse); 
      expect(copiedComments.length, equals(comments.length)); 
      expect(copiedComments, isNot(same(comments))); 
      copiedComments.forEach((e) => 
        expect(e, equals(comments.singleWhereOid(e.oid)))); 
 
      //copiedComments.display(title: "Copy comments"); 
    }); 
 
    test("True for every comment", () { 
      expect(comments.every((e) => e.text != null), isTrue); 
    }); 
 
    test("Random comment", () { 
      var comment1 = comments.random(); 
      expect(comment1, isNotNull); 
      var comment2 = comments.random(); 
      expect(comment2, isNotNull); 
 
      //comment1.display(prefix: "random1"); 
      //comment2.display(prefix: "random2"); 
    }); 
 
  }); 
} 
 
void main() { 
  testCategoryLinksComment(new Repository(), "Category", "Links"); 
} 
 
