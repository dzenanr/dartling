
class DartlingRepo extends Repo {

  static final categoryQuestionDomainCode = 'CategoryQuestion';
  static final categoryQuestionLinkModelCode = 'Link';

  static final davidCurtisDomainCode = 'DavidCurtis';
  static final davidCurtisInstitutionModelCode = 'Institution';

  static final defaultDomainCode = 'Default';
  static final defaultProjectModelCode = 'Project';
  static final defaultUserModelCode = 'User';

  DartlingRepo([String code='Dartling']) : super(code) {
    _init();
  }

  _initCategoryQuestionDomain() {
    var categoryquestionDomain = new Domain(categoryQuestionDomainCode);
    domains.add(categoryquestionDomain);
    add(new CategoryQuestionModels(categoryquestionDomain));
  }

  _initDavidCurtisDomain() {
    var davidcurtisDomain = new Domain(davidCurtisDomainCode);
    domains.add(davidcurtisDomain);
    add(new DavidCurtisModels(davidcurtisDomain));
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
