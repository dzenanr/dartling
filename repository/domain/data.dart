
class DomainData implements SourceOfActionReaction {

  Domain _domain;

  Map<String, ModelData> _modelDataMap;
  // for transactions to be able to use multiple models
  List<ActionReaction> _actionReactions;

  DomainData(this._domain) {
    _modelDataMap = new Map<String, ModelData>();
    _actionReactions = new List<ActionReaction>();
  }

  bool add(ModelData modelData) {
    var code = modelData.model.code;
    var md = _modelDataMap[code];
    if (md == null) {
      _modelDataMap[code] = modelData;
    } else {
      throw new CodeException(
        'The $code code exists already in the ${_domain.code} domain data.');
    }
  }

  Domain get domain() => _domain;

  ModelData getModelData(String code) => _modelDataMap[code];

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