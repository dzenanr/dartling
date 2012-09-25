
// data/gen/category_question/models.dart

class CategoryQuestionModels extends DomainModels {

  CategoryQuestionModels(Domain domain) : super(domain) {
    add(fromJsonToLinkEntries());
  }

  LinkEntries fromJsonToLinkEntries() {
    return new LinkEntries(fromMagicBoxes(
      categoryQuestionLinkModelJson,
      domain,
      CategoryQuestionRepo.categoryQuestionLinkModelCode));
  }

}





