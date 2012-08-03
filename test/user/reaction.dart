
class MemberReaction implements ActionReaction {

  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  react(Action action) {
    Members ms;
    Member m;
    if (action is EntitiesAction) {
      //ms = action.entities;
      reactedOnAdd = true;
    } else if (action is EntityAction) {
      //m = action.entity;
      reactedOnUpdate = true;
    }
  }

}

