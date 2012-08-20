
class DartlingRepo extends Repo {

  static final categoryquestionDomainCode = 'CategoryQuestion';
  static final categoryquestionLinkModelCode = 'Link';

  static final davidcurtisDomainCode = 'DavidCurtis';
  static final davidcurtisInstitutionModelCode = 'Institution';

  static final defaultDomainCode = 'Default';
  static final defaultProjectModelCode = 'Project';
  static final defaultUserModelCode = 'User';

  DartlingRepo([String code='Dartling']) : super(new Domains(), code) {
    _init();
  }

  _initCategoryQuestionDomain() {
    var categoryquestionDomain = new Domain(categoryquestionDomainCode);
    domains.add(categoryquestionDomain);
    add(new CategoryQuestionModels(categoryquestionDomain));
  }

  _initDavidCurtisDomain() {
    var davidcurtisDomain = new Domain(davidcurtisDomainCode);
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
