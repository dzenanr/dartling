## Version history of [dartling](http://pub.dartlang.org/packages/dartling)

based on [Semantic Versioning](http://semver.org/)

*2.0.0* 2014-03-09

+ generate model init with initChildren ordered by external parent count
+ external parent count for concept parents
+ rename base type to origin type
+ generate mutiple tests per entry concept
+ generate a test file per entry concept
+ generate model init with internal children
+ update code gen (specific repo, domain and model; model entry json)
+ remove displayJson() in generated code
+ in addition to String, num and DateTime attribute ids,
  you can order on Uri and bool attribute ids
+ improve entries.fromJson based on the entry concept internal tree
+ for a parent reference in JSON, instead of only oid string,
  use a map of oid  string, parent concept code and entry concept code
+ change API in lib/domain/model/entries.dart:
  EntityApi single(Oid oid);
  EntityApi internalSingle(String entryConceptCode, Oid oid);
  EntitiesApi internalChild(String entryConceptCode, Oid oid);
  String toJson(String entryConceptCode);
  fromJson(String json);
+ change API in lib/domain/model/entities.dart:
  EntityApi internalSingle(Oid oid);
  EntitiesApi internalChild(Oid oid);
  removed: List<Map<String, Object>> toJson();
+ update README.md

*1.0.6* 2014-02-25

+ add return null when there is a warning

*1.0.5* 2014-02-25

+ in code gen replace new Uri.fromString by Uri.parse

*1.0.4* 2013-12-03

+ remove unreachable code

*1.0.3* 2013-11-28

+ when loading data from a json document avoid creating entities that have been already created

*1.0.2* 2013-11-25

+ rename LOG.md to CHANGELOG.md
+ update pubspec.yaml: Homepage and Documentation links

*1.0.1* 2013-11-07

+ update README.md to display web links properly

