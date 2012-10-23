//part of category_keyword;

// data/gen/category/repository.dart

class CategoryRepo extends Repo {

  static final categoryDomainCode = "Category";
  static final categoryKeywordModelCode = "Keyword";

  CategoryRepo([String code="CategoryRepo"]) : super(code) {
    _initCategoryDomain();
  }

  _initCategoryDomain() {
    var categoryDomain = new Domain(categoryDomainCode);
    domains.add(categoryDomain);
    add(new CategoryModels(categoryDomain));
  }

}


