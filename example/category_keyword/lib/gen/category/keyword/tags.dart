part of category_keyword;

// data/gen/category/keyword/tags.dart

abstract class TagGen extends ConceptEntity<Tag> {

  TagGen(Concept concept) : super.of(concept);

  TagGen.withId(Concept concept, Keyword keyword, Category category) : super.of(concept) {
    setParent("keyword", keyword);
    setParent("category", category);
  }

  Keyword get keyword => getParent("keyword");
  set keyword(Keyword p) => setParent("keyword", p);

  Category get category => getParent("category");
  set category(Category p) => setParent("category", p);

  Tag newEntity() => new Tag(concept);

}

abstract class TagsGen extends Entities<Tag> {

  TagsGen(Concept concept) : super.of(concept);

  Tags newEntities() => new Tags(concept);

}

