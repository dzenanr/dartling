
class Interest extends InterestGen {

  Interest(Concept concept) : super(concept);

  Interest.withId(Concept concept,
      Member member, Category category) :
        super.withId(concept, member, category);

}

class Interests extends InterestsGen {

  Interests(Concept concept) : super(concept);

}
