part of category_question_link;

// data/category_question/link/questions.dart

class Question extends QuestionGen {

  Question(Concept concept) : super(concept);

  Question.withId(Concept concept, int number) :
    super.withId(concept, number);

}

class Questions extends QuestionsGen {

  Questions(Concept concept) : super(concept);

}


