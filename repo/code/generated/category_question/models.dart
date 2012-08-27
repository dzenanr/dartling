
class CategoryQuestionModels extends DomainModels {

  CategoryQuestionModels(Domain domain) : super(domain) {
    add(fromJsonToLinkEntries());
  }

  LinkEntries fromJsonToLinkEntries() {
    return new LinkEntries(fromMagicBoxes(
      categoryQuestionLinkModelInJson,
      domain,
      DartlingRepo.categoryQuestionLinkModelCode));
  }

}
