part of dartling;

String genDartlingWeb(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// web/${domain.codeLowerUnderscore}/${model.codeLowerUnderscore}/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}_web.dart \n';
  sc = '${sc} \n';

  sc = '${sc}import "dart:html"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:dartling/dartling.dart"; \n';
  sc = '${sc}import "package:dartling_default_app/dartling_default_app.dart"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}init${domain.code}Data(${domain.code}Repo '
       '${domain.codeFirstLetterLower}Repo) { \n';
  sc = '${sc}   var ${domain.codeFirstLetterLower}Models = \n';
  sc = '${sc}       ${domain.codeFirstLetterLower}Repo.'
       'getDomainModels(${domain.code}Repo.'
       '${domain.codeFirstLetterLower}DomainCode); \n';
  sc = '${sc} \n';
  sc = '${sc}   var ${domain.codeFirstLetterLower}${model.code}Entries = \n';
  sc = '${sc}       ${domain.codeFirstLetterLower}Models.'
       'getModelEntries(${domain.code}Repo.${domain.codeFirstLetterLower}'
       '${model.code}ModelCode); \n';
  sc = '${sc}   init${domain.code}${model.code}('
       '${domain.codeFirstLetterLower}${model.code}Entries); \n';
  sc = '${sc}   ${domain.codeFirstLetterLower}${model.code}Entries.display(); \n';
  sc = '${sc}   ${domain.codeFirstLetterLower}${model.code}'
       'Entries.displayJson(); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}show${domain.code}Data(${domain.code}Repo '
       '${domain.codeFirstLetterLower}Repo) { \n';
  sc = '${sc}   var mainView = new View(document, "main"); \n';
  sc = '${sc}   mainView.repo = ${domain.codeFirstLetterLower}Repo; \n';
  sc = '${sc}   new RepoMainSection(mainView); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  sc = '${sc}void main() { \n';
  sc = '${sc}  var ${domain.codeFirstLetterLower}Repo = '
       'new ${domain.code}Repo(); \n';
  sc = '${sc}  init${domain.code}Data(${domain.codeFirstLetterLower}Repo); \n';
  sc = '${sc}  show${domain.code}Data(${domain.codeFirstLetterLower}Repo); \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}
