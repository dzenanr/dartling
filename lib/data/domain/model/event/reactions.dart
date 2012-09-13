
abstract class SourceOfActionReactionApi {

  abstract startActionReaction(ActionReactionApi reaction);
  abstract cancelActionReaction(ActionReactionApi reaction);
  abstract notifyActionReactions(ActionApi action);
}

abstract class SourceOfPastReactionApi {

  abstract startPastReaction(PastReactionApi reaction);
  abstract cancelPastReaction(PastReactionApi reaction);
  abstract notifyNoPast();
  abstract notifyYesPast();
}

abstract class ActionReactionApi {

  abstract react(ActionApi action);
}

abstract class PastReactionApi {

  abstract reactNoPast();
  abstract reactYesPast();
}





