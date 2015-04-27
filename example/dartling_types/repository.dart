part of dartling_types; 
 
// lib/repository.dart 
 
class Repository extends Repo { 
 
  static const REPOSITORY = "Repository"; 
 
  Repository([String code=REPOSITORY]) : super(code) { 
    var domain = new Domain("Dartling"); 
    domains.add(domain); 
    add(new DartlingDomain(domain)); 
 
  } 
 
} 
 
