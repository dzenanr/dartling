part of dartling;

abstract class SourceOfActionReactionApi {

  void startActionReaction(ActionReactionApi reaction);
  void cancelActionReaction(ActionReactionApi reaction);

  void notifyActionReactions(ActionApi action);

}

abstract class SourceOfPastReactionApi {

  void startPastReaction(PastReactionApi reaction);
  void cancelPastReaction(PastReactionApi reaction);

  void notifyCannotUndo();
  void notifyCanUndo();
  void notifyCanRedo();
  void notifyCannotRedo();

}

abstract class ActionReactionApi {

  void react(ActionApi action);

}

abstract class PastReactionApi {

  void reactCannotUndo();
  void reactCanUndo();
  void reactCanRedo();
  void reactCannotRedo();

}





