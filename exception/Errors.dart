
class Errors extends Entities<Error> {

  /**
   * Displays (prints) a title, then errors.
   */
   display([String title='Entities', bool withOid=true]) {
     if (title != '') {
       print('');
       print('******================================');
       print('$title                                ');
       print('******================================');
       print('');
     }
     for (Error error in this) {
       error.display('*** ');
     }
   }

}
