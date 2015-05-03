part of category_links; 
 
// lib/category/links/members.dart 
 
class Member extends MemberGen { 
 
  Member(Concept concept) : super(concept); 
 
  Member.withId(Concept concept, String email) : 
    super.withId(concept, email); 
 
  // added after code gen - begin 
 
  bool get ridjanovic => lastName.contains('Ridjanovic') ? true : false;

  /**
   * Compares two members based on the last and first names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Member other) {
    var c = lastName.compareTo(other.lastName);
    if (c == 0) {
      return firstName.compareTo(other.firstName);
    }
    return c;
  }

  /**
   * Compares two members based on code.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareCode(Member other) {
    return code.compareTo(other.code);
  }
  
  // added after code gen - end 
 
} 
 
class Members extends MembersGen { 
 
  Members(Concept concept) : super(concept); 
 
  // added after code gen - begin 
 
  /*
  bool preAdd(Member member) {
    bool validation = super.preAdd(member);
    if (validation) {
      List<String> roles = ['regular', 'manager', 'admin'];
      validation = roles.any((r) => r == member.role);
      if (!validation) {
        var error = new ValidationError('pre');
        error.message =
            '${concept.codes}.preAdd rejects the ${member.role} role.';
        errors.add(error);
      }
    }
    return validation;
  }
  */
  
  // added after code gen - end 
 
} 
 
