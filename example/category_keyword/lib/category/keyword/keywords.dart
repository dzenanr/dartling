//part of category_keyword;

// data/category/keyword/keywords.dart

class Keyword extends KeywordGen {

  Keyword(Concept concept) : super(concept);

  Keyword.withId(Concept concept, String word) :
    super.withId(concept, word);

}

class Keywords extends KeywordsGen {

  Keywords(Concept concept) : super(concept);

}

