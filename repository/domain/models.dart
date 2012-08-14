
abstract class DomainModelsApi implements SourceOfActionReactionApi {

  abstract add(ModelEntriesApi modelEntries);
  abstract Domain get domain();
  abstract ModelEntriesApi getModelEntries(String modelCode);
  abstract DomainSessionApi newSession();
  abstract fromJson(String json);

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
    var modelCode = modelEntries.model.code;
    var entries = _modelEntriesMap[modelCode];
    if (entries == null) {
      _modelEntriesMap[modelCode] = modelEntries;
    } else {
      throw new CodeException(
        'The ${modelCode} model exists already in the ${_domain.code} domain.');
    }
  }

  Domain get domain() => _domain;

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

  notifyActionReactions(Action action) {
    for (ActionReactionApi reaction in _actionReactions) {
      reaction.react(action);
    }
  }

  fromJson(String json) {
    Map<String, Object> modelMap = JSON.parse(json);
    var domainCode = modelMap['domain'];
    if (_domain.code != domainCode) {
      throw new CodeException('The ${domainCode} domain does not exist.');
    }
    var modelCode = modelMap['model'];
    if (!modelMap.containsKey(modelCode)) {
      throw new CodeException(
        'The ${modelCode} model does not exist in the ${_domain.code} domain.');
    }
    ModelEntries modelEntries = getModelEntries(modelCode);
    List<Map<String, Object>> entriesList = modelMap['entries'];
    modelEntries.entriesFromJson(entriesList);
  }

}