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

library dartling;

import 'dart:convert';
import 'dart:math';

part 'domain/model/event/actions.dart';
part 'domain/model/event/past.dart';
part 'domain/model/event/reactions.dart';
part 'domain/model/error/errors.dart';
part 'domain/model/error/validations.dart';
part 'domain/model/transfer/json.dart';
part 'domain/model/entities.dart';
part 'domain/model/entity.dart';
part 'domain/model/entries.dart';
part 'domain/model/id.dart';
part 'domain/model/oid.dart';
part 'domain/models.dart';
part 'domain/session.dart';

part 'gen/dartling_gen.dart';
part 'gen/dartling_library.dart';
part 'gen/dartling_library_app.dart';
part 'gen/dartling_model_generic.dart';
part 'gen/dartling_model_specific.dart';
part 'gen/dartling_test.dart';
part 'gen/dartling_web.dart';

part 'meta/attributes.dart';
part 'meta/children.dart';
part 'meta/concepts.dart';
part 'meta/domains.dart';
part 'meta/models.dart';
part 'meta/neighbor.dart';
part 'meta/parents.dart';
part 'meta/property.dart';
part 'meta/types.dart';

part 'repository.dart';

