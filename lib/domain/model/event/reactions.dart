part of dartling;

abstract class SourceOfActionReactionApi {

  startActionReaction(ActionReactionApi reaction);
  cancelActionReaction(ActionReactionApi reaction);

  notifyActionReactions(ActionApi action);

}

abstract class SourceOfPastReactionApi {

  startPastReaction(PastReactionApi reaction);
  cancelPastReaction(PastReactionApi reaction);

  notifyCannotUndo();
  notifyCanUndo();
  notifyCanRedo();
  notifyCannotRedo();

}

abstract class ActionReactionApi {

  react(ActionApi action);

}

abstract class PastReactionApi {

  reactCannotUndo();
  reactCanUndo();
  reactCanRedo();
  reactCannotRedo();

}





