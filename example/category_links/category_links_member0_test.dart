import "package:test/test.dart";
import 'category_links.dart';
 
testCategoryLinksMember( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var model; 
  var members; 
  group("Testing Category.Links.Member", () { 
    domain = repository.getDomainModels(domainCode); 
    model = domain.getModelEntries(modelCode); 
    members = model.members; 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(model.isEmpty, isFalse); 
      expect(members.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      model.clear(); 
      expect(model.isEmpty, isTrue); 
      expect(members.isEmpty, isTrue); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = model.fromEntryToJson("Member"); 
      expect(json, isNotNull); 
 
      print(json); 
      //model.displayEntryJson("Member"); 
      //model.displayJson(); 
      //model.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = model.fromEntryToJson("Member"); 
      members.clear(); 
      expect(members.isEmpty, isTrue); 
      model.fromJsonToEntry(json); 
      expect(members.isEmpty, isFalse); 
 
      members.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add member required error", () { 
      var memberConcept = members.concept; 
      var memberCount = members.length; 
      var member = new Member(memberConcept); 
      var added = members.add(member); 
      expect(added, isFalse); 
      expect(members.length, equals(memberCount)); 
      expect(members.errors.length, greaterThan(0)); 
      expect(members.errors.toList()[0].category, equals("required")); 
 
      members.errors.display(title: "Add member required error"); 
    }); 
 
    test("Add member unique error", () { 
      var memberConcept = members.concept; 
      var memberCount = members.length; 
      var member = new Member(memberConcept); 
      var randomMember = members.random(); 
      member.email = randomMember.email; 
      var added = members.add(member); 
      expect(added, isFalse); 
      expect(members.length, equals(memberCount)); 
      expect(members.errors.length, greaterThan(0)); 
 
      members.errors.display(title: "Add member unique error"); 
    }); 
 
    test("Find member by firstName", () { 
      var randomMember = members.random(); 
      var memberFirstName = randomMember.firstName; 
      Member member = members.firstWhereAttribute("firstName", memberFirstName); 
      expect(member, isNotNull); 
    }); 
 
    test("Select members by firstName", () { 
      var randomMember = members.random(); 
      var memberFirstName = randomMember.firstName; 
      var selectedMembers = members.selectWhereAttribute("firstName", memberFirstName); 
      expect(selectedMembers.isEmpty, isFalse); 
 
      //selectedMembers.display(title: "Select members by firstName"); 
    }); 
 
    test("Sort members", () { 
      members.sort(); 
 
      //members.display(title: "Sort members"); 
    }); 
 
    test("Order members", () { 
      var orderedMembers = members.order(); 
      expect(orderedMembers.isEmpty, isFalse); 
      expect(orderedMembers.length, equals(members.length)); 
      expect(orderedMembers.source.isEmpty, isFalse); 
      expect(orderedMembers.source.length, equals(members.length)); 
      expect(orderedMembers, isNot(same(members))); 
 
      //orderedMembers.display(title: "Order members"); 
    }); 
 
    test("Copy members", () { 
      var copiedMembers = members.copy(); 
      expect(copiedMembers.isEmpty, isFalse); 
      expect(copiedMembers.length, equals(members.length)); 
      expect(copiedMembers, isNot(same(members))); 
      copiedMembers.forEach((e) => 
        expect(e, equals(members.singleWhereOid(e.oid)))); 
      copiedMembers.forEach((e) => 
        expect(e, isNot(same(members.singleWhereId(e.id))))); 
 
      //copiedMembers.display(title: "Copy members"); 
    }); 
 
    test("True for every member", () { 
      expect(members.every((e) => e.firstName != null), isTrue); 
    }); 
 
    test("Random member", () { 
      var member1 = members.random(); 
      expect(member1, isNotNull); 
      var member2 = members.random(); 
      expect(member2, isNotNull); 
 
      //member1.display(prefix: "random1"); 
      //member2.display(prefix: "random2"); 
    }); 
 
  }); 
} 
 
void main() { 
  testCategoryLinksMember(new Repository(), "Category", "Links"); 
} 
 
