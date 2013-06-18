part of dartling;

String genDartlingGen(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// test/${domain.codeLowerUnderscore}/${model.codeLowerUnderscore}/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}_gen.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:dartling/dartling.dart"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}genCode() { \n';
  sc = '${sc}  var repo = new Repo(); \n';
  sc = '${sc} \n';
  sc = '${sc}  var ${domain.codeFirstLetterLower}Domain = '
       'new Domain("${domain.code}"); \n';
  sc = '${sc} \n';
  sc = '${sc}  Model ${domain.codeFirstLetterLower}'
       '${model.code}Model = \n';
  sc = '${sc}      fromJsonToModel(${domain.codeFirstLetterLower}'
       '${model.code}ModelJson, '
       '${domain.codeFirstLetterLower}'
       'Domain, "${model.code}"); \n';
  sc = '${sc} \n';
  sc = '${sc}  repo.domains.add(${domain.codeFirstLetterLower}'
       'Domain); \n';
  sc = '${sc} \n';
  sc = '${sc}  repo.gen("${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}"); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}init${domain.code}Data(${domain.code}Repo '
       '${domain.codeFirstLetterLower}Repo) { \n';
  sc = '${sc}   var ${domain.codeFirstLetterLower}Models = \n';
  sc = '${sc}       ${domain.codeFirstLetterLower}Repo.'
       'getDomainModels(${domain.code}Repo.'
       '${domain.codeFirstLetterLower}DomainCode); \n';
  sc = '${sc} \n';
  sc = '${sc}   var ${domain.codeFirstLetterLower}${model.code}'
       'Entries = \n';
  sc = '${sc}       ${domain.codeFirstLetterLower}Models.'
       'getModelEntries(${domain.code}Repo.'
       '${domain.codeFirstLetterLower}'
       '${model.code}ModelCode); \n';
  sc = '${sc}   init${domain.code}${model.code}('
       '${domain.codeFirstLetterLower}${model.code}'
       'Entries); \n';
  sc = '${sc}   ${domain.codeFirstLetterLower}${model.code}'
       'Entries.display(); \n';
  sc = '${sc}   ${domain.codeFirstLetterLower}${model.code}'
       'Entries.displayJson(); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  sc = '${sc}  genCode(); \n';
  sc = '${sc} \n';
  sc = '${sc}  var ${domain.codeFirstLetterLower}Repo = '
       'new ${domain.code}Repo(); \n';
  sc = '${sc}  init${domain.code}Data(${domain.codeFirstLetterLower}Repo); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}
