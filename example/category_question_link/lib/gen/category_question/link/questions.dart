
// data/gen/category_question/link/questions.dart

abstract class QuestionGen extends ConceptEntity<Question> {

  QuestionGen(Concept concept) : super.of(concept);

  QuestionGen.withId(Concept concept, int number) : super.of(concept) {
    setAttribute("number", number);
  }

  Category get category => getParent("category");
  set category(Category p) => setParent("category", p);

  int get number => getAttribute("number");
  set number(int a) => setAttribute("number", a);

  String get type => getAttribute("type");
  set type(String a) => setAttribute("type", a);

  String get text => getAttribute("text");
  set text(String a) => setAttribute("text", a);

  String get response => getAttribute("response");
  set response(String a) => setAttribute("response", a);

  String get createdOn => getAttribute("createdOn");
  set createdOn(String a) => setAttribute("createdOn", a);

  num get points => getAttribute("points");
  set points(num a) => setAttribute("points", a);

  Question newEntity() => new Question(concept);

  int numberCompareTo(Question other) {
    return number.compareTo(other.number);
  }

}

abstract class QuestionsGen extends Entities<Question> {

  QuestionsGen(Concept concept) : super.of(concept);

  Questions newEntities() => new Questions(concept);

}


