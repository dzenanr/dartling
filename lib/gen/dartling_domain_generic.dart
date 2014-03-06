part of dartling;

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