
// data/category_question/link/interests.dart

class Interest extends InterestGen {

  Interest(Concept concept) : super(concept);

  Interest.withId(Concept concept, Category category, Member member) :
    super.withId(concept, category, member);

}

class Interests extends InterestsGen {

  Interests(Concept concept) : super(concept);

}


