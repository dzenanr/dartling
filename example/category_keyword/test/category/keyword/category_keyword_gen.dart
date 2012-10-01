
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

#import("package:dartling/dartling.dart");

// pub
//#import("package:category_keyword/category_keyword.dart");

#source("../../../lib/category/keyword/json/data.dart");
#source("../../../lib/category/keyword/json/model.dart");
#source("../../../lib/category/keyword/init.dart");
#source("../../../lib/category/keyword/categories.dart");
#source("../../../lib/category/keyword/keywords.dart");
#source("../../../lib/category/keyword/tags.dart");
#source("../../../lib/gen/category/keyword/entries.dart");
#source("../../../lib/gen/category/keyword/categories.dart");
#source("../../../lib/gen/category/keyword/keywords.dart");
#source("../../../lib/gen/category/keyword/tags.dart");
#source("../../../lib/gen/category/models.dart");
#source("../../../lib/gen/category/repository.dart");
// pub

genCode() {
  var repo = new Repo();

  // change "Dartling" to "YourDomainName"
  var categoryDomain = new Domain("Category");

  // change dartling to yourDomainName
  // change Skeleton to YourModelName
  // change "Skeleton" to "YourModelName"
  Model categoryKeywordModel =
      fromMagicBoxes(categoryKeywordModelJson, categoryDomain, "Keyword");

  repo.domains.add(categoryDomain);

  repo.gen();
  //repo.gen(specific:false);
}

initCategoryData(CategoryRepo categoryRepo) {
   var categoryModels =
       categoryRepo.getDomainModels(CategoryRepo.categoryDomainCode);

   var categoryKeywordEntries =
       categoryModels.getModelEntries(CategoryRepo.categoryKeywordModelCode);
   initCategoryKeyword(categoryKeywordEntries);
   categoryKeywordEntries.display();
   categoryKeywordEntries.displayJson();
}

void main() {
  genCode();
  
  var categoryRepo = new CategoryRepo();
  initCategoryData(categoryRepo);
}
