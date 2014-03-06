part of dartling;

String genRepo(Domain domain, String library) {
  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/repo.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${domain.code}Repo extends ${domain.code}Repository { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${domain.code}Repo() : super(); \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}

String genDomain(Domain domain, String library) {
  var sc = 'part of ${library}; \n';
  sc = '${sc} \n';
  sc = '${sc}// lib/${domain.codeLowerUnderscore}/domain.dart \n';
  sc = '${sc} \n';
  sc = '${sc}class ${domain.code}Domain extends ${domain.code}Models { \n';
  sc = '${sc} \n';
  sc = '${sc}  ${domain.code}Domain(Domain domain) : super(domain); \n';
  sc = '${sc} \n';
  sc = '${sc}} \n';
  sc = '${sc} \n';

  return sc;
}
