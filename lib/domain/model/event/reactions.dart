
abstract class SourceOfActionReactionApi {

  startActionReaction(ActionReactionApi reaction);
  cancelActionReaction(ActionReactionApi reaction);
  notifyActionReactions(ActionApi action);
  
}

abstract class SourceOfPastReactionApi {

  startPastReaction(PastReactionApi reaction);
  cancelPastReaction(PastReactionApi reaction);
  notifyNoPast();
  notifyYesPast();
  
}

abstract class ActionReactionApi {

  react(ActionApi action);
  
}

abstract class PastReactionApi {

  reactNoPast();
  reactYesPast();
  
}





