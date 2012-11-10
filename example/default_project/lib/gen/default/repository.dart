part of default_project;

// data/gen/default/repository.dart

class DefaultRepo extends Repo {

  static final defaultDomainCode = "Default";
  static final defaultProjectModelCode = "Project";

  DefaultRepo({String code: "DefaultRepo"}) : super(code) {
    _initDefaultDomain();
  }

  _initDefaultDomain() {
    var defaultDomain = new Domain(defaultDomainCode);
    domains.add(defaultDomain);
    add(new DefaultModels(defaultDomain));
  }

}


