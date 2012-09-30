
#import("package:dartling/dartling.dart");
#import("package:dartling/dartling_app.dart");
#import("package:art_pen/art_pen.dart");
#import("package:art_pen/art_pen_app.dart");

#import("dart:html");

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


