part of todo_mvc; 
 
// lib/repository.dart 
 
class Repository extends Repo { 
 
  static const REPOSITORY = "Repository"; 
 
  Repository([String code=REPOSITORY]) : super(code) { 
    var domain = new Domain("Todo"); 
    domains.add(domain); 
    add(new TodoDomain(domain)); 
 
  } 
 
} 
 
