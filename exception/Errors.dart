
class Errors extends Entities<Error> {

  /**
   * Displays (prints) a title, then errors.
   */
   display([String title='Entities', bool withOid=true]) {
     if (title == 'Entities') {
       title = 'Errors';
     }
     print('');
     print('************************************************');
     print('$title                                          ');
     print('************************************************');
     print('');
     for (Error error in this) {
       error.display('*** ');
     }
   }

}
