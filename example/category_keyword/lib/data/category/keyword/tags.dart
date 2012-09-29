
// data/category/keyword/tags.dart

class Tag extends TagGen {

  Tag(Concept concept) : super(concept);

  Tag.withId(Concept concept, Keyword keyword, Category category) :
    super.withId(concept, keyword, category);

}

class Tags extends TagsGen {

  Tags(Concept concept) : super(concept);

}


