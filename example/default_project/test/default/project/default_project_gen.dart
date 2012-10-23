
/*
http://opensource.org/licenses/

http://en.wikipedia.org/wiki/BSD_license
3-clause license ("New BSD License" or "Modified BSD License")

Copyright (c) 2012, Dartling project authors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Dartling nor the
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

import 'package:dartling/dartling.dart';

// pub
//import 'package:default_project/default_project.dart';

part '../../../lib/default/project/json/data.dart';
part '../../../lib/default/project/json/model.dart';
part '../../../lib/default/project/init.dart';
part '../../../lib/default/project/projects.dart';
part '../../../lib/gen/default/project/entries.dart';
part '../../../lib/gen/default/project/projects.dart';
part '../../../lib/gen/default/models.dart';
part '../../../lib/gen/default/repository.dart';
// pub

genCode() {
  var repo = new Repo();

  // change "Dartling" to "YourDomainName"
  var defaultDomain = new Domain("Default");

  // change dartling to yourDomainName
  // change Skeleton to YourModelName
  // change "Skeleton" to "YourModelName"
  Model defaultProjectModel =
      fromMagicBoxes(defaultProjectModelJson, defaultDomain, "Project");

  repo.domains.add(defaultDomain);

  repo.gen('default_project');
}

initDefaultData(DefaultRepo defaultRepo) {
   var defaultModels =
       defaultRepo.getDomainModels(DefaultRepo.defaultDomainCode);

   var defaultProjectEntries =
       defaultModels.getModelEntries(DefaultRepo.defaultProjectModelCode);
   initDefaultProject(defaultProjectEntries);
   defaultProjectEntries.display();
   defaultProjectEntries.displayJson();
}

void main() {
  genCode();

  var defaultRepo = new DefaultRepo();
  initDefaultData(defaultRepo);
}
