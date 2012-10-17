
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

#library('art_pen_app');

#import("dart:html");
#import('dart:isolate');
#import("dart:math");

#import("package:dartling/dartling.dart");
#import("package:dartling/dartling_app.dart");


// pub
//#import("package:art_pen/art_pen.dart");

#source("art/pen/json/data.dart");
#source("art/pen/json/model.dart");

#source("art/pen/init.dart");
#source("art/pen/segments.dart");
#source("art/pen/lines.dart");

#source("gen/art/pen/entries.dart");
#source("gen/art/pen/segments.dart");
#source("gen/art/pen/lines.dart");
#source("gen/art/models.dart");
#source("gen/art/repository.dart");

// added by hand
#source("art/pen/pen.dart");
#source("art/pen/examples.dart");
#source("art/pen/programs.dart");

#source("util/color.dart");
#source("util/random.dart");

// pub

// added by hand
#source("app/commands.dart");
#source("app/drawing.dart");
