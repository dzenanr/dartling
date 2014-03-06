part of dartling;

String genRepository(Domain domain, String library) {
  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/gen/${domain.codeLowerUnderscore}/repository.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${domain.code}Repository extends Repo { \n';
  sc = '${sc} \n';
  sc = '${sc}  static const REPOSITORY = "${domain.code}Repository"; \n';
  sc = '${sc}  static const DOMAIN = "${domain.code}"; \n';
  sc = '${sc} \n';
  sc = '${sc}  ${domain.code}Repository([String code=REPOSITORY]) : '
       'super(code) { \n';
  sc = '${sc}    var domain = new Domain(DOMAIN); \n';
  sc = '${sc}    domains.add(domain); \n';
  sc = '${sc}    add(new ${domain.code}Domain(domain)); \n';
  sc = '${sc}  } \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genModels(Domain domain, String library) {
  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/gen/${domain.codeLowerUnderscore}/models.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${domain.code}Models extends DomainModels { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${domain.code}Models(Domain domain) : super(domain) { \n';
  sc = '${sc}    // fromJsonToModel function from dartling/lib/domain/model/transfer.json.dart \n';
  sc = '${sc} \n';
  for (Model model in domain.models) {
    sc = '${sc}    Model model = fromJsonToModel(${domain.codeFirstLetterLower}'
         '${model.code}ModelJson, domain, "${model.code}"); \n';
    sc = '${sc}    ${model.code}Model ${model.codeFirstLetterLower}Model = '
         'new ${model.code}Model(model); \n';
    sc = '${sc}    add(${model.codeFirstLetterLower}Model); \n';
    sc = '${sc} \n';
  }
  sc = '${sc}  } \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}