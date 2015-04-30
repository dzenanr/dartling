import "dart:io";  
import 'todo_mvc.dart';

/*
 * Based on http://www.dartlang.org/articles/json-web-service/.
 * A web server that responds to GET and POST requests.
 * Use it at http://localhost:8080.
 */

const String HOST = "127.0.0.1"; // eg: localhost
const int PORT = 8080;

Tasks serverTasks;

void _integrateDataFromClient(String json) {
  var clientTasks = new Tasks(serverTasks.concept);
  clientTasks.fromJson(json);
  for (var serverTask in serverTasks.toList()) {
    var clientTask = clientTasks.singleWhereOid(serverTask.oid);
    if (clientTask == null) {
      serverTasks.remove(serverTask);
    }
  }
  for (var clientTask in clientTasks) {
    var serverTask = serverTasks.singleWhereOid(clientTask.oid);
    if (serverTask != null) {
      if (serverTask.whenSet.millisecondsSinceEpoch <
          clientTask.whenSet.millisecondsSinceEpoch) {
        serverTask.completed = clientTask.completed;
      }
    } else {
      serverTasks.add(clientTask);
    }
  }    
}

void start() {
  HttpServer.bind(HOST, PORT)
    .then((server) {
      server.listen((HttpRequest request) {
        switch (request.method) {
          case "GET":
            handleGet(request);
            break;
          case 'POST':
            handlePost(request);
            break;
          case 'OPTIONS':
            handleOptions(request);
            break;
          default: defaultHandler(request);
        }
      }, onError: print);
    })
    .catchError(print)
    .whenComplete(() => print('Listening for GET and POST on http://$HOST:$PORT'));
}

void handleGet(HttpRequest request) {
  HttpResponse res = request.response;
  print('${request.method}: ${request.uri.path}');

  addCorsHeaders(res);
  res.headers.contentType =
      new ContentType("application", "json", charset: 'utf-8');
  String json = serverTasks.toJson();
  print('JSON in GET: ${json}');
  res.write(json);
  res.close();
}

void handlePost(HttpRequest request) {
  print('${request.method}: ${request.uri.path}');
  request.listen((List<int> buffer) {
    var json = new String.fromCharCodes(buffer);
    print('JSON in POST: ${json}');
    _integrateDataFromClient(json);
  },
  onError: print);
}

/**
 * Add Cross-site headers to enable accessing this server from pages
 * not served by this server
 *
 * See: http://www.html5rocks.com/en/tutorials/cors/
 * and http://enable-cors.org/server.html
 */
void addCorsHeaders(HttpResponse response) {
  response.headers.add('Access-Control-Allow-Origin', '*, ');
  response.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
  response.headers.add('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
}

void handleOptions(HttpRequest request) {
  HttpResponse res = request.response;
  addCorsHeaders(res);
  print('${request.method}: ${request.uri.path}');
  res.statusCode = HttpStatus.NO_CONTENT;
  res.close();
}

void defaultHandler(HttpRequest request) {
  HttpResponse res = request.response;
  addCorsHeaders(res);
  res.statusCode = HttpStatus.NOT_FOUND;
  res.write('Not found: ${request.method}, ${request.uri.path}');
  res.close();
}

void main() {
  var repository = new Repository();
  var domain = repository.getDomainModels('Todo');
  var model = domain.getModelEntries('Mvc');
  serverTasks = model.tasks;
  start();
}


