
abstract class SourceOfActionReaction {

  abstract startActionReaction(ActionReaction reaction);
  abstract cancelActionReaction(ActionReaction reaction);
  abstract notifyActionReactions(Action action);
}

abstract class SourceOfPastReaction {

  abstract startPastReaction(PastReaction reaction);
  abstract cancelPastReaction(PastReaction reaction);
  abstract notifyNoPast();
  abstract notifyYesPast();
}

abstract class ActionReaction {

  abstract react(Action action);
}

abstract class PastReaction {

  abstract reactNoPast();
  abstract reactYesPast();
}





