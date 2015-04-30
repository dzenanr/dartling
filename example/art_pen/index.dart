import 'art_pen.dart';
import 'art_pen_app.dart';

void main() {
  var repo = new ArtRepo();
  var board = new Board(repo);
  new Commands(board.pen);
}


