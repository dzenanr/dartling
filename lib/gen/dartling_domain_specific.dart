part of dartling;

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
