
createWebLibrary() {
  var library = new Library();
  var categories = library.categories;
  
  var dartCategory = new Category(library.categoryConcept);
  dartCategory.code = 'Dart';
  dartCategory.description = 'Dart Web language.';
  categories.add(dartCategory);
  
  var html5Category = new Category(library.categoryConcept);
  html5Category.code = 'HTML5';
  html5Category.description = 'HTML5 is the ubiquitous platform for the web.';
  categories.add(html5Category);
  
  var dartHomeWebLink = new WebLink(library.webLinkConcept);
  dartHomeWebLink.code = 'Dart Home';
  dartHomeWebLink.url = 'http://www.dartlang.org/';
  dartHomeWebLink.description = 'Dart brings structure to web app engineering with a new language, libraries, and tools.';
  dartCategory.webLinks.add(dartHomeWebLink);
  dartHomeWebLink.category = dartCategory;
  
  var tryDartWebLink = new WebLink(library.webLinkConcept);
  tryDartWebLink.code = 'Try Dart';
  tryDartWebLink.url = 'http://try.dartlang.org/';
  tryDartWebLink.description = 'Try out the Dart Language from the comfort of your web browser.';
  dartCategory.webLinks.add(tryDartWebLink);
  tryDartWebLink.category = dartCategory;
  
  print('');
  print('******************');
  print('Create Web Library');
  print('******************');
  print('');
  //categories.display();
  categories.display(withOid: true);
}
