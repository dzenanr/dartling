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

#import('dart:json');
#import('dart:math');
#import('dart:uri');

#import('package:unittest/unittest.dart');

#source('domain/model/event/actions.dart');
#source('domain/model/event/reactions.dart');
#source('domain/model/exception/errors.dart');
#source('domain/model/exception/exceptions.dart');
#source('domain/model/transfer/json.dart');
#source('domain/model/entities.dart');
#source('domain/model/entity.dart');
#source('domain/model/entries.dart');
#source('domain/model/id.dart');
#source('domain/model/oid.dart');
#source('domain/models.dart');
#source('domain/session.dart');

#source('gen/dartling_app.dart');
#source('gen/dartling_gen.dart');
#source('gen/generated.dart');
#source('gen/specific.dart');
#source('gen/tests.dart');

#source('meta/attributes.dart');
#source('meta/children.dart');
#source('meta/concepts.dart');
#source('meta/domains.dart');
#source('meta/models.dart');
#source('meta/neighbor.dart');
#source('meta/parents.dart');
#source('meta/property.dart');
#source('meta/types.dart');

#source('repository.dart');

