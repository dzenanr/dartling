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

#library('dartling');

//#import('package:unittest/unittest.dart');
#import('../unittest/unittest.dart');
#import('dart:json');
#import('dart:math');
#import('dart:uri');

#source('data/domain/model/event/actions.dart');
#source('data/domain/model/event/reactions.dart');
#source('data/domain/model/exception/errors.dart');
#source('data/domain/model/exception/exceptions.dart');
#source('data/domain/model/transfer/json.dart');
#source('data/domain/model/entities.dart');
#source('data/domain/model/entity.dart');
#source('data/domain/model/entries.dart');
#source('data/domain/model/id.dart');
#source('data/domain/model/oid.dart');
#source('data/domain/models.dart');
#source('data/domain/session.dart');

#source('data/gen/app.dart');
#source('data/gen/dartling.dart');
#source('data/gen/generated.dart');
#source('data/gen/specific.dart');
#source('data/gen/tests.dart');

#source('data/meta/attributes.dart');
#source('data/meta/children.dart');
#source('data/meta/concepts.dart');
#source('data/meta/domains.dart');
#source('data/meta/models.dart');
#source('data/meta/neighbor.dart');
#source('data/meta/parents.dart');
#source('data/meta/property.dart');
#source('data/meta/types.dart');

#source('data/repository.dart');

#source("view/component/entities.dart");
#source("view/component/entity.dart");
#source("view/component/param.dart");
#source("view/component/repo.dart");

void main() {

}
