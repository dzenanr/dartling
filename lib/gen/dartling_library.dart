part of dartling;

var license =
'''
/*
http://opensource.org/licenses/

http://en.wikipedia.org/wiki/BSD_license
3-clause license ("New BSD License" or "Modified BSD License")

Copyright (c) 2012, dartling project authors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the dartling nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
''';

String genDartlingLibrary(Model model) {
  Domain domain = model.domain;

  var sc = ' \n';
  sc = '${sc}// lib/'
       '${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}.dart \n';
  sc = '${sc} \n';

  sc = '${sc}${license} \n';
  sc = '${sc} \n';

  sc = '${sc}library ${domain.codeLowerUnderscore}_${model.codeLowerUnderscore}; \n';
  sc = '${sc} \n';

  sc = '${sc}import "dart:convert"; \n';
  sc = '${sc}import "dart:math"; \n';
  sc = '${sc} \n';

  sc = '${sc}import "package:dartling/dartling.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}part "${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/json/data.dart"; \n';
  sc = '${sc}part "${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/json/model.dart"; \n';
  sc = '${sc} \n';

  sc = '${sc}part "${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/init.dart"; \n';
  sc = '${sc} \n';

  for (Concept concept in model.concepts) {
    sc = '${sc}part "${domain.codeLowerUnderscore}/'
         '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart"; \n';
  }
  sc = '${sc} \n';

  sc = '${sc}part "gen/${domain.codeLowerUnderscore}/'
       '${model.codeLowerUnderscore}/entries.dart"; \n';
  for (Concept concept in model.concepts) {
    sc = '${sc}part "gen/${domain.codeLowerUnderscore}/'
         '${model.codeLowerUnderscore}/${concept.codesLowerUnderscore}.dart"; \n';
  }
  sc = '${sc} \n';

  sc = '${sc}part "gen/${domain.codeLowerUnderscore}/'
       'models.dart"; \n';
  sc = '${sc}part "gen/${domain.codeLowerUnderscore}/'
       'repository.dart"; \n';
  sc = '${sc} \n';

  return sc;
}

