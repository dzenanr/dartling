
class DomainModels implements SourceOfActionReaction {

  Domain _domain;

  Map<String, ModelEntries> _modelEntriesMap;
  // for transactions to be able to use multiple models
  List<ActionReaction> _actionReactions;

  DomainModels(this._domain) {
    _modelEntriesMap = new Map<String, ModelEntries>();
    _actionReactions = new List<ActionReaction>();
  }

  bool add(ModelEntries modelEntries) {
    var code = modelEntries.model.code;
    var entries = _modelEntriesMap[code];
    if (entries == null) {
      _modelEntriesMap[code] = modelEntries;
    } else {
      throw new CodeException(
        'The $code code exists already in the ${_domain.code} domain data.');
    }
  }

  Domain get domain() => _domain;

  ModelEntries getModelEntries(String code) => _modelEntriesMap[code];

  DomainSession newSession() {
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