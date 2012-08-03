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

#library('Dartling');

#import('../../unittest/unittest.dart');
#import('dart:json');
#import('dart:uri');

#source('data/project/Data.dart');
#source('data/project/Project.dart');
#source('data/project/Projects.dart');
#source('data/user/Data.dart');
#source('data/user/Member.dart');
#source('data/user/Members.dart');
#source('data/web/Categories.dart');
#source('data/web/Category.dart');
#source('data/web/Data.dart');
#source('data/web/WebLink.dart');
#source('data/web/WebLinks.dart');

#source('exception/error.dart');
#source('exception/s.dart');

#source('guid/Oid.dart');

#source('meta/Attribute.dart');
#source('meta/Attributes.dart');
#source('meta/Child.dart');
#source('meta/Children.dart');
#source('meta/Concept.dart');
#source('meta/Concepts.dart');
#source('meta/Domain.dart');
#source('meta/Domains.dart');
#source('meta/Model.dart');
#source('meta/Models.dart');
#source('meta/Neighbor.dart');
#source('meta/Parent.dart');
#source('meta/Parents.dart');
#source('meta/Property.dart');
#source('meta/Type.dart');
#source('meta/Types.dart');

#source('model/Data.dart');
#source('model/Entities.dart');
#source('model/Entity.dart');
#source('model/Id.dart');

#source('operation/reaction.dart');
#source('operation/action.dart');

#source('test/lastGroupTest.dart');
#source('test/lastSingleTest.dart');
#source('test/project/data.dart');
#source('test/project/reaction.dart');
#source('test/user/data.dart');
#source('test/user/reaction.dart');
#source('test/web/data.dart');
#source('test/web/model.dart');

#source('transfer/json.dart');

allTests() {
  testProjectData();
  testUserData();
  testWebData();
  testWebModel();
  //lastSingleTest();
  //lastGroupTest();
}

void main() {
  allTests();
}