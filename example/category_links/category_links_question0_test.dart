import "package:test/test.dart";
import 'category_links.dart';
 
void testCategoryLinksQuestion( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var model; 
  var questions; 
  group("Testing Category.Links.Question", () { 
    domain = repository.getDomainModels(domainCode); 
    model = domain.getModelEntries(modelCode); 
    questions = model.questions; 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(model.isEmpty, isFalse); 
      expect(questions.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      model.clear(); 
      expect(model.isEmpty, isTrue); 
      expect(questions.isEmpty, isTrue); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = model.fromEntryToJson("Question"); 
      expect(json, isNotNull); 
 
      print(json); 
      //model.displayEntryJson("Question"); 
      //model.displayJson(); 
      //model.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = model.fromEntryToJson("Question"); 
      questions.clear(); 
      expect(questions.isEmpty, isTrue); 
      model.fromJsonToEntry(json); 
      expect(questions.isEmpty, isFalse); 
 
      questions.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add question required error", () { 
      var questionConcept = questions.concept; 
      var questionCount = questions.length; 
      var question = new Question(questionConcept); 
      var added = questions.add(question); 
      expect(added, isFalse); 
      expect(questions.length, equals(questionCount)); 
      expect(questions.exceptions.length, greaterThan(0)); 
      expect(questions.exceptions.toList()[0].category, equals("required")); 
 
      questions.exceptions.display(title: "Add question required error"); 
    }); 
 
    test("Add question unique error", () { 
      // id attribute defined as increment, cannot update it 
    }); 
 
    test("Find question by text", () { 
      var randomQuestion = questions.random(); 
      var questionText = randomQuestion.text; 
      Question question = questions.firstWhereAttribute("text", questionText); 
      expect(question, isNotNull); 
    }); 
 
    test("Select questions by text", () { 
      var randomQuestion = questions.random(); 
      var questionText = randomQuestion.text; 
      var selectedQuestions = questions.selectWhereAttribute("text", questionText); 
      expect(selectedQuestions.isEmpty, isFalse); 
 
      //selectedQuestions.display(title: "Select questions by text"); 
    }); 
 
    test("Sort questions", () { 
      questions.sort(); 
 
      //questions.display(title: "Sort questions"); 
    }); 
 
    test("Order questions", () { 
      var orderedQuestions = questions.order(); 
      expect(orderedQuestions.isEmpty, isFalse); 
      expect(orderedQuestions.length, equals(questions.length)); 
      expect(orderedQuestions.source.isEmpty, isFalse); 
      expect(orderedQuestions.source.length, equals(questions.length)); 
      expect(orderedQuestions, isNot(same(questions))); 
 
      //orderedQuestions.display(title: "Order questions"); 
    }); 
 
    test("Copy questions", () { 
      var copiedQuestions = questions.copy(); 
      expect(copiedQuestions.isEmpty, isFalse); 
      expect(copiedQuestions.length, equals(questions.length)); 
      expect(copiedQuestions, isNot(same(questions))); 
      copiedQuestions.forEach((e) => 
        expect(e, equals(questions.singleWhereOid(e.oid)))); 
      copiedQuestions.forEach((e) => 
        expect(e, isNot(same(questions.singleWhereId(e.id))))); 
 
      //copiedQuestions.display(title: "Copy questions"); 
    }); 
 
    test("True for every question", () { 
      expect(questions.every((e) => e.text != null), isTrue); 
    }); 
 
    test("Random question", () { 
      var question1 = questions.random(); 
      expect(question1, isNotNull); 
      var question2 = questions.random(); 
      expect(question2, isNotNull); 
 
      //question1.display(prefix: "random1"); 
      //question2.display(prefix: "random2"); 
    }); 
 
  }); 
} 
 
void main() { 
  testCategoryLinksQuestion(new Repository(), "Category", "Links"); 
} 
 
