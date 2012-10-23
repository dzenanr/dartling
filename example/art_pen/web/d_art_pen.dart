
import 'dart:html';
import 'dart:isolate';
import 'dart:math';

import 'package:dartling/dartling.dart';
import 'package:dartling/dartling_app.dart';

// pub
//import 'package:art_pen/art_pen.dart';

part '../lib/art/pen/json/data.dart';
part '../lib/art/pen/json/model.dart';

part '../lib/art/pen/init.dart';
part '../lib/art/pen/segments.dart';
part '../lib/art/pen/lines.dart';

part '../lib/art/pen/pen.dart';
part '../lib/art/pen/examples.dart';
part '../lib/art/pen/programs.dart';

part '../lib/gen/art/pen/entries.dart';
part '../lib/gen/art/pen/segments.dart';
part '../lib/gen/art/pen/lines.dart';
part '../lib/gen/art/models.dart';
part '../lib/gen/art/repository.dart';

part '../lib/util/color.dart';
part '../lib/util/random.dart';

// pub

// pub
//import 'package:art_pen/art_pen_app.dart';

part '../lib/app/drawing.dart';
part '../lib/app/commands.dart';

// pub

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


