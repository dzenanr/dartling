
class Library {
  
  Concept categoryConcept;
  Concept webLinkConcept;
  
  Categories categories;
  
  Library() {
    Domain domain = new Domain();
    Model model = new Model(domain);
    
    categoryConcept = new Concept(model, 'Category');
    categoryConcept.description = 'Category of web links.';
    Attribute categoryDescriptionAttribute = new Attribute(categoryConcept, 'description');
    
    webLinkConcept = new Concept(model, 'WebLink');
    webLinkConcept.entry = false;
    webLinkConcept.description = 'Web links of interest.';
    Attribute webLinkUrlAttribute = new Attribute(webLinkConcept, 'url');
    Attribute webLinkDescriptionAttribute = new Attribute(webLinkConcept, 'description');
    
    Neighbor categoryWebLinksNeighbor = new Neighbor(categoryConcept, webLinkConcept, 'webLinks');
    categoryWebLinksNeighbor.max = 'N';
    Neighbor webLinkCategoryNeighbor = new Neighbor(webLinkConcept, categoryConcept, 'category');
    webLinkCategoryNeighbor.id = true;
    webLinkCategoryNeighbor.child = false;
    
    categories = new Categories(categoryConcept);
  }
  
}


