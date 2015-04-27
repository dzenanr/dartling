part of default_project; 
 
// lib/repository.dart 
 
class Repository extends Repo { 
 
  static const REPOSITORY = "Repository"; 
 
  Repository([String code=REPOSITORY]) : super(code) { 
    var domain = new Domain("Default"); 
    domains.add(domain); 
    add(new DefaultDomain(domain)); 
 
  } 
 
} 
 
