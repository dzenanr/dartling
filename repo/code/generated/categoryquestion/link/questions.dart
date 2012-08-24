
abstract class QuestionGen extends ConceptEntity<Question> {

  QuestionGen(Concept concept) : super.of(concept);

  // id is increment => no constructor with id

  Category get category() => getParent('category');
  set category(Category p) => setParent('category', p);

  int get number() => getAttribute('number');
  set number(int a) => setAttribute('number', a);

  String get type() => getAttribute('type');
  set type(String a) => setAttribute('type', a);

  String get text() => getAttribute('text');
  set text(String a) => setAttribute('text', a);

  String get response() => getAttribute('response');
  set response(String a) => setAttribute('response', a);

  Date get createdOn() => getAttribute('createdOn');
  set createdOn(Date a) => setAttribute('createdOn', a);

  num get points() => getAttribute('points');
  set points(num a) => setAttribute('points', a);

}

abstract class QuestionsGen extends Entities<Question> {

  QuestionsGen(Concept concept) : super.of(concept);

  Questions newEntities() => new Questions(concept);

}
