
class Entry implements SourceOfActionReaction {

  Domain _domain;

  Map<String, Data> _dataMap;

  List<ActionReaction> _actionReactions; // for transactions

  Entry(this._domain) {
    _dataMap = newData();
    _actionReactions = new List<ActionReaction>();
  }

  Map<String, Data> newData() {
    var data = new Map<String, Data>();
    _domain.models.forEach((m) {data[m.code] = new Data(m);});
    return data;
  }

  Domain get domain() => _domain;

  Data getData(String code) => _dataMap[code];

  DomainSession getNewSession() {
    return new DomainSession(this);
  }

  startActionReaction(ActionReaction reaction) => _actionReactions.add(reaction);
  cancelActionReaction(ActionReaction reaction) {
    int index = _actionReactions.indexOf(reaction, 0);
    _actionReactions.removeRange(index, 1);
  }

  notifyActionReactions(Action action) {
    for (ActionReaction reaction in _actionReactions) {
      reaction.react(action);
    }
  }

}