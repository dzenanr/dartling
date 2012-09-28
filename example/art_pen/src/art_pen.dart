
//#import("package:unittest/unittest.dart", prefix:"unittest");
//#import("../../../../unittest/unittest.dart", prefix:"unittest");

#import("dart:html");
//#import("dart:json");
#import("dart:math");
//#import("dart:uri");

#import("package:dartling/dartling.dart");
#import("package:dartling/dartling_view.dart");

/*
#source("../../../lib/data/domain/model/event/actions.dart");
#source("../../../lib/data/domain/model/event/reactions.dart");
#source("../../../lib/data/domain/model/exception/errors.dart");
#source("../../../lib/data/domain/model/exception/exceptions.dart");
#source("../../../lib/data/domain/model/transfer/json.dart");
#source("../../../lib/data/domain/model/entities.dart");
#source("../../../lib/data/domain/model/entity.dart");
#source("../../../lib/data/domain/model/entries.dart");
#source("../../../lib/data/domain/model/id.dart");
#source("../../../lib/data/domain/model/oid.dart");
#source("../../../lib/data/domain/models.dart");
#source("../../../lib/data/domain/session.dart");

#source("../../../lib/data/gen/dartling_data.dart");
#source("../../../lib/data/gen/dartling_view.dart");
#source("../../../lib/data/gen/generated.dart");
#source("../../../lib/data/gen/specific.dart");
#source("../../../lib/data/gen/tests.dart");

#source("../../../lib/data/meta/attributes.dart");
#source("../../../lib/data/meta/children.dart");
#source("../../../lib/data/meta/concepts.dart");
#source("../../../lib/data/meta/domains.dart");
#source("../../../lib/data/meta/models.dart");
#source("../../../lib/data/meta/neighbor.dart");
#source("../../../lib/data/meta/parents.dart");
#source("../../../lib/data/meta/property.dart");
#source("../../../lib/data/meta/types.dart");

#source("../../../lib/data/repository.dart");

#source("../../../lib/view/component/entities.dart");
#source("../../../lib/view/component/entity.dart");
#source("../../../lib/view/component/param.dart");
#source("../../../lib/view/component/repo.dart");
*/

#source("data/art/pen/json/data.dart");
#source("data/art/pen/json/model.dart");
#source("data/art/pen/init.dart");
#source("data/art/pen/segments.dart");
#source("data/art/pen/lines.dart");

#source("data/gen/art/pen/entries.dart");
#source("data/gen/art/pen/segments.dart");
#source("data/gen/art/pen/lines.dart");
#source("data/gen/art/models.dart");
#source("data/gen/art/repository.dart");

#source("data/art/pen/pen.dart");
#source("data/art/pen/program.dart");

#source("util/color.dart");
#source("util/random.dart");

#source("view/drawing.dart");
#source("view/program.dart");

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


