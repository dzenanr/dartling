## Version history of [dartling](http://pub.dartlang.org/packages/dartling)

based on [Semantic Versioning](http://semver.org/)

*1.0.7* 2014-02-27

+ lib/domain/model/entries.dart: in ModelEntries, debug the fromJson method
  (problem when set parent that is identifier)
+ can order only on String, num and DateTime attribute ids;
  if other type then improve the error message
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

