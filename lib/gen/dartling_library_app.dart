part of dartling;

String genDartlingLibraryApp(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// lib/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}_app.dart \n';
  sc = '${sc} \n';

  sc = '${sc}${license} \n';
  sc = '${sc} \n';

  sc = '${sc}library ${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}_app; \n';
  sc = '${sc} \n';

  sc = '${sc}import "dart:html"; \n';
  sc = '${sc}import "dart:math"; \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:dartling/dartling.dart"; \n';
  sc = '${sc}import "package:dartling_default_app/dartling_default_app.dart"; \n';
  sc = '${sc} \n';
  sc = '${sc}import "package:${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}/${domain.codeLowerUnderscore}_'
       '${model.codeLowerUnderscore}.dart"; \n';
  sc = '${sc} \n';

  return sc;
}


