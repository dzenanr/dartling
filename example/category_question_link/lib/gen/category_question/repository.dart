
// data/gen/category_question/repository.dart

class CategoryQuestionRepo extends Repo {

  static final categoryQuestionDomainCode = "CategoryQuestion";
  static final categoryQuestionLinkModelCode = "Link";

  CategoryQuestionRepo([String code="CategoryQuestionRepo"]) : super(code) {
    _initCategoryQuestionDomain();
  }

  _initCategoryQuestionDomain() {
    var categoryQuestionDomain = new Domain(categoryQuestionDomainCode);
    domains.add(categoryQuestionDomain);
    add(new CategoryQuestionModels(categoryQuestionDomain));
  }

}


