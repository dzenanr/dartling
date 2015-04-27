 
part of category_links; 
 
// lib/category/links/model.dart 
 
class LinksModel extends LinksEntries { 
 
  LinksModel(Model model) : super(model); 
 
  fromJsonToMemberEntry() { 
    fromJsonToEntry(categoryLinksMemberEntry); 
  } 
 
  fromJsonToCategoryEntry() { 
    fromJsonToEntry(categoryLinksCategoryEntry); 
  } 
 
  fromJsonToCommentEntry() { 
    fromJsonToEntry(categoryLinksCommentEntry); 
  } 
 
  fromJsonToQuestionEntry() { 
    fromJsonToEntry(categoryLinksQuestionEntry); 
  } 
 
  fromJsonToModel() { 
    fromJson(categoryLinksModel); 
  } 
 
  init() { 
    initCategories(); 
    initMembers(); 
    initComments(); 
    initQuestions(); 
  } 
 
  initMembers() { 
    var member1 = new Member(members.concept); 
    member1.email = "sara@rodriguez.com"; 
    member1.firstName = "tall"; 
    member1.lastName = "do"; 
    member1.startedOn = new DateTime.now(); 
    member1.receiveEmail = true; 
    member1.password = "family"; 
    member1.role = "cable"; 
    member1.karma = 977.7744051432732; 
    member1.about = "done"; 
    members.add(member1); 
 
    var member1interests1 = new Interest(member1.interests.concept); 
    member1interests1.description = "pencil"; 
    var member1interests1Category = categories.random(); 
    member1interests1.category = member1interests1Category; 
    member1interests1.member = member1; 
    member1.interests.add(member1interests1); 
    member1interests1Category.interests.add(member1interests1); 
 
    var member1interests2 = new Interest(member1.interests.concept); 
    member1interests2.description = "done"; 
    var member1interests2Category = categories.random(); 
    member1interests2.category = member1interests2Category; 
    member1interests2.member = member1; 
    member1.interests.add(member1interests2); 
    member1interests2Category.interests.add(member1interests2); 
 
    var member2 = new Member(members.concept); 
    member2.email = "michelle@cruz.com"; 
    member2.firstName = "beginning"; 
    member2.lastName = "selfdo"; 
    member2.startedOn = new DateTime.now(); 
    member2.receiveEmail = false; 
    member2.password = "river"; 
    member2.role = "family"; 
    member2.karma = 112; 
    member2.about = "capacity"; 
    members.add(member2); 
 
    var member2interests1 = new Interest(member2.interests.concept); 
    member2interests1.description = "agile"; 
    var member2interests1Category = categories.random(); 
    member2interests1.category = member2interests1Category; 
    member2interests1.member = member2; 
    member2.interests.add(member2interests1); 
    member2interests1Category.interests.add(member2interests1); 
 
    var member2interests2 = new Interest(member2.interests.concept); 
    member2interests2.description = "season"; 
    var member2interests2Category = categories.random(); 
    member2interests2.category = member2interests2Category; 
    member2interests2.member = member2; 
    member2.interests.add(member2interests2); 
    member2interests2Category.interests.add(member2interests2); 
 
    var member3 = new Member(members.concept); 
    member3.email = "ryan@baker.com"; 
    member3.firstName = "call"; 
    member3.lastName = "taxi"; 
    member3.startedOn = new DateTime.now(); 
    member3.receiveEmail = true; 
    member3.password = "hall"; 
    member3.role = "cloud"; 
    member3.karma = 882.7201579524965; 
    member3.about = "account"; 
    members.add(member3); 
 
    var member3interests1 = new Interest(member3.interests.concept); 
    member3interests1.description = "consciousness"; 
    var member3interests1Category = categories.random(); 
    member3interests1.category = member3interests1Category; 
    member3interests1.member = member3; 
    member3.interests.add(member3interests1); 
    member3interests1Category.interests.add(member3interests1); 
 
    var member3interests2 = new Interest(member3.interests.concept); 
    member3interests2.description = "ticket"; 
    var member3interests2Category = categories.random(); 
    member3interests2.category = member3interests2Category; 
    member3interests2.member = member3; 
    member3.interests.add(member3interests2); 
    member3interests2Category.interests.add(member3interests2); 
 
  } 
 
  initCategories() { 
    var category1 = new Category(categories.concept); 
    category1.name = "web"; 
    category1.description = "email"; 
    category1.approved = false; 
    categories.add(category1); 
 
    var category1webLinks1 = new WebLink(category1.webLinks.concept); 
    category1webLinks1.subject = "electronic"; 
    category1webLinks1.url = Uri.parse("https://github.com/ErikGrimes/polymer_ui_elements"); 
    category1webLinks1.description = "sin"; 
    category1webLinks1.createdOn = new DateTime.now(); 
    category1webLinks1.updatedOn = new DateTime.now(); 
    category1webLinks1.approved = false; 
    category1webLinks1.category = category1; 
    category1.webLinks.add(category1webLinks1); 
 
    var category1webLinks2 = new WebLink(category1.webLinks.concept); 
    category1webLinks2.subject = "teaching"; 
    category1webLinks2.url = Uri.parse("http://www.sarahmei.com/blog/2013/11/11/why-you-should-never-use-mongodb/"); 
    category1webLinks2.description = "ship"; 
    category1webLinks2.createdOn = new DateTime.now(); 
    category1webLinks2.updatedOn = new DateTime.now(); 
    category1webLinks2.approved = true; 
    category1webLinks2.category = category1; 
    category1.webLinks.add(category1webLinks2); 
 
    var category2 = new Category(categories.concept); 
    category2.name = "chemist"; 
    category2.description = "umbrella"; 
    category2.approved = false; 
    categories.add(category2); 
 
    var category2webLinks1 = new WebLink(category2.webLinks.concept); 
    category2webLinks1.subject = "hot"; 
    category2webLinks1.url = Uri.parse("http://www.fastcompany.com/3021179/secrets-of-running-a-six-figure-airbnb-business"); 
    category2webLinks1.description = "teaching"; 
    category2webLinks1.createdOn = new DateTime.now(); 
    category2webLinks1.updatedOn = new DateTime.now(); 
    category2webLinks1.approved = true; 
    category2webLinks1.category = category2; 
    category2.webLinks.add(category2webLinks1); 
 
    var category2webLinks2 = new WebLink(category2.webLinks.concept); 
    category2webLinks2.subject = "mile"; 
    category2webLinks2.url = Uri.parse("http://fivera.net/create-a-self-hosted-wordpress-site-for-free/"); 
    category2webLinks2.description = "algorithm"; 
    category2webLinks2.createdOn = new DateTime.now(); 
    category2webLinks2.updatedOn = new DateTime.now(); 
    category2webLinks2.approved = false; 
    category2webLinks2.category = category2; 
    category2.webLinks.add(category2webLinks2); 
 
    var category3 = new Category(categories.concept); 
    category3.name = "health"; 
    category3.description = "navigation"; 
    category3.approved = true; 
    categories.add(category3); 
 
    var category3webLinks1 = new WebLink(category3.webLinks.concept); 
    category3webLinks1.subject = "beans"; 
    category3webLinks1.url = Uri.parse("http://www.nomadmicrohomes.com/"); 
    category3webLinks1.description = "judge"; 
    category3webLinks1.createdOn = new DateTime.now(); 
    category3webLinks1.updatedOn = new DateTime.now(); 
    category3webLinks1.approved = false; 
    category3webLinks1.category = category3; 
    category3.webLinks.add(category3webLinks1); 
 
    var category3webLinks2 = new WebLink(category3.webLinks.concept); 
    category3webLinks2.subject = "baby"; 
    category3webLinks2.url = Uri.parse("http://www.mymodernmet.com/profiles/blogs/ian-lorne-kent-nomad-micro-home"); 
    category3webLinks2.description = "pattern"; 
    category3webLinks2.createdOn = new DateTime.now(); 
    category3webLinks2.updatedOn = new DateTime.now(); 
    category3webLinks2.approved = true; 
    category3webLinks2.category = category3; 
    category3.webLinks.add(category3webLinks2); 
 
  } 
 
  initComments() { 
    var comment1 = new Comment(comments.concept); 
    comment1.text = "hat"; 
    comment1.source = "east"; 
    comment1.createdOn = new DateTime.now(); 
    comments.add(comment1); 
 
    var comment2 = new Comment(comments.concept); 
    comment2.text = "effort"; 
    comment2.source = "team"; 
    comment2.createdOn = new DateTime.now(); 
    comments.add(comment2); 
 
    var comment3 = new Comment(comments.concept); 
    comment3.text = "hot"; 
    comment3.source = "explanation"; 
    comment3.createdOn = new DateTime.now(); 
    comments.add(comment3); 
 
  } 
 
  initQuestions() { 
    var question1 = new Question(questions.concept); 
    question1.type = "observation"; 
    question1.text = "video"; 
    question1.response = "pattern"; 
    question1.createdOn = "employer"; 
    question1.points = 85.57957236826886; 
    questions.add(question1); 
 
    var question2 = new Question(questions.concept); 
    question2.type = "life"; 
    question2.text = "umbrella"; 
    question2.response = "accomodation"; 
    question2.createdOn = "privacy"; 
    question2.points = -921; 
    questions.add(question2); 
 
    var question3 = new Question(questions.concept); 
    question3.type = "lake"; 
    question3.text = "tape"; 
    question3.response = "privacy"; 
    question3.createdOn = "advisor"; 
    question3.points = 929.3635539281017; 
    questions.add(question3); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 
