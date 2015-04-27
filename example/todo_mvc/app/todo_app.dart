part of todo_mvc_app;

class TodoApp {
  TodoDomain domain;
  DomainSession session;
  Tasks clientTasks;

  Header _header;
  Element _main = querySelector('#main');
  Todos _todos;
  Element _errors = querySelector('#errors');
  Footer footer;
  
  String serverResponse = '';

  TodoApp(this.domain) {
    session = domain.newSession();
    MvcModel model = domain.getModelEntries('Mvc');
    clientTasks = model.tasks;

    _header = new Header(this);
    _todos = new Todos(this);
    footer = new Footer(this, _todos);

    _load();
    
    ButtonElement toServer = querySelector('#to-server');
    toServer.onClick.listen((MouseEvent e) {
      var request = new HttpRequest();
      request.onReadyStateChange.listen((_) {
        if (request.readyState == HttpRequest.DONE && request.status == 200) {
          serverResponse = 'Server: ' + request.responseText;
        } else if (request.readyState == HttpRequest.DONE && request.status == 0) {
          // Status is 0...most likely the server isn't running.
          serverResponse = 'No server';
        }
      });

      var url = 'http://127.0.0.1:8080';
      request.open('POST', url);
      request.send(clientTasks.toJson());
    });

    ButtonElement fromServer = querySelector('#from-server');
    fromServer.onClick.listen((MouseEvent e) {
      HttpRequest.getString('http://127.0.0.1:8080')
        .then((String json) {
          serverResponse = 'Server: ' + json;
          print('JSON text from the server: ${json}');
          if (json != '') {
            _integrateDataFromServer(json);
          }
        });
    });
  }

  _load() {
    String json = window.localStorage['todos'];
    if (json != null) {
      clientTasks.fromJson(json);
      for (Task task in clientTasks) {
        _todos.add(task);
      }
    }
    updateDisplay();
  }

  save() {
    window.localStorage['todos'] = clientTasks.toJson();
  }
  
  _integrateDataFromServer(String json) {
    var serverTasks = new Tasks(clientTasks.concept);
    serverTasks.fromJson(json);
    for (var clientTask in clientTasks.toList()) {
      var serverTask = serverTasks.singleWhereOid(clientTask.oid);
      if (serverTask == null) {
        new RemoveAction(session, clientTasks, clientTask).doit();
      }
    }
    for (var serverTask in serverTasks) {
      var clientTask = clientTasks.singleWhereOid(serverTask.oid);
      if (clientTask != null) {
        if (clientTask.whenSet.millisecondsSinceEpoch <
            serverTask.whenSet.millisecondsSinceEpoch) {
          new SetAttributeAction(session, clientTask, 'completed', serverTask.completed).doit();
        }
      } else {
        new AddAction(session, clientTasks, serverTask).doit();
      }
    } 
  }

  possibleErrors() {
    _errors.innerHtml = '<p>${clientTasks.errors.toString()}</p>';
    clientTasks.errors.clear();
  }

  updateDisplay() {
    var display = clientTasks.length == 0 ? 'none' : 'block';
    _main.style.display = display;
    _header.updateDisplay();
    footer.updateDisplay();
    possibleErrors();
  }
}

