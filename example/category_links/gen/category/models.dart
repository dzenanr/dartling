part of category_links; 
 
// lib/gen/category/models.dart 
 
class CategoryModels extends DomainModels { 
 
  CategoryModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from dartling/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(categoryLinksModelJson, domain, "Links"); 
    LinksModel linksModel = new LinksModel(model); 
    add(linksModel); 
 
  } 
 
} 
 
