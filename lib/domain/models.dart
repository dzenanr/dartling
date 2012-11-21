part of dartling;

abstract class DomainModelsApi implements SourceOfActionReactionApi {

  add(ModelEntriesApi modelEntries);
  Domain get domain;
  Model getModel(String modelCode);
  ModelEntriesApi getModelEntries(String modelCode);
  DomainSessionApi newSession();

}

class DomainModels implements DomainModelsApi {

  Domain _domain;

  Map<String, ModelEntries> _modelEntriesMap;
  // for transactions to be able to use multiple models
  List<ActionReactionApi> _actionReactions;

  DomainModels(this._domain) {
    _modelEntriesMap = new Map<String, ModelEntries>();
    _actionReactions = new List<ActionReactionApi>();
  }

  add(ModelEntries modelEntries) {
    var domainCode = modelEntries.model.domain.code;
    if (_domain.code != domainCode) {
      var msg = 'The ${domainCode} domain of the model is different from '
          'the ${_domain.code} domain.';
      throw new CodeError(msg);
    }
    var modelCode = modelEntries.model.code;
    var entries = _modelEntriesMap[modelCode];
    if (entries == null) {
      _modelEntriesMap[modelCode] = modelEntries;
    } else {
      throw new CodeError(
        'The ${modelCode} model exists already in the ${_domain.code} domain.');
    }
  }

  Domain get domain => _domain;

  Model getModel(String modelCode) {
    return _domain.getModel(modelCode);
  }

  ModelEntries getModelEntries(String modelCode) =>
      _modelEntriesMap[modelCode];

  DomainSession newSession() {
    return new DomainSession(this);
  }

  startActionReaction(ActionReactionApi reaction) =>
      _actionReactions.add(reaction);
  cancelActionReaction(ActionReactionApi reaction) {
    int index = _actionReactions.indexOf(reaction, 0);
    _actionReactions.removeRange(index, 1);
  }

  notifyActionReactions(BasicAction action) {
    for (ActionReactionApi reaction in _actionReactions) {
      reaction.react(action);
    }
  }

}