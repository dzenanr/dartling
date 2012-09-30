
#import("dart:html");
#import("dart:math");

#import("package:dartling/dartling.dart");
#import("package:dartling/dartling_app.dart");

//#import("package:art_pen/art_pen.dart");

#source("../lib/art/pen/json/data.dart");
#source("../lib/art/pen/json/model.dart");

#source("../lib/art/pen/init.dart");
#source("../lib/art/pen/segments.dart");
#source("../lib/art/pen/lines.dart");

#source("../lib/art/pen/pen.dart");
#source("../lib/art/pen/examples.dart");
#source("../lib/art/pen/programs.dart");

#source("../lib/gen/art/pen/entries.dart");
#source("../lib/gen/art/pen/segments.dart");
#source("../lib/gen/art/pen/lines.dart");
#source("../lib/gen/art/models.dart");
#source("../lib/gen/art/repository.dart");

#source("../lib/util/color.dart");
#source("../lib/util/random.dart");

//#import("package:art_pen/art_pen_app.dart");

#source("../lib/app/drawing.dart");
#source("../lib/app/commands.dart");

showMinData(ArtRepo minRepo) {
   var mainView = new View(document, "main");
   mainView.repo = minRepo;
   new RepoMainSection(mainView);
}

main() {
  var minRepo = new ArtRepo();
  showMinData(minRepo);
  var board = new Board(minRepo);
  new Commands(board.pen);
}


