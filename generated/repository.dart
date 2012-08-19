
class DartlingRepo extends Repo {

  static final categoryQuestionDomainCode = 'CategoryQuestion';
  static final categoryQuestionLinkModelCode = 'Link';

  static final davidCurtisDomainCode = 'DavidCurtis';
  static final davidCurtisInstitutionModelCode = 'Institution';

  static final defaultDomainCode = 'Default';
  static final defaultProjectModelCode = 'Project';
  static final defaultUserModelCode = 'User';

  DartlingRepo() : super(new Domains()) {
    _init();
  }

  _initCategoryQuestionDomain() {
    var categoryQuestionDomain = new Domain(categoryQuestionDomainCode);
    domains.add(categoryQuestionDomain);
    add(new CategoryQuestionModels(categoryQuestionDomain));
  }

  _initDavidCurtisDomain() {
    var davidCurtisDomain = new Domain(davidCurtisDomainCode);
    domains.add(davidCurtisDomain);
    add(new DavidCurtisModels(davidCurtisDomain));
  }

  _initDefaultDomain() {
    var defaultDomain = new Domain();
    domains.add(defaultDomain);
    add(new DefaultModels(defaultDomain));
  }

  _init() {
    _initCategoryQuestionDomain();
    _initDavidCurtisDomain();
    _initDefaultDomain();
  }

}
