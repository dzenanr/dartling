part of dartling;

String dropEnd(String text, String end) {
  if (text != null && end != null) {
    String withoutEnd = text;
    int endPosition = text.lastIndexOf(end);
    if (endPosition > 0) {
      // drop the end
      withoutEnd = text.substring(0, endPosition);
    }
    return withoutEnd;
  }
  return null;
}

String plural(String text) {
  if (text != null) {
    var t = text.trim();
    if (t == '') {
      return '';
    }
    var result;
    String lastLetter = t.substring(t.length - 1, t.length);
    if (lastLetter == 'x') {
      result = '${t}es';
    } else if (lastLetter == 'z') {
      result = '${t}zes';
    } else if (lastLetter == 'y') {
      String withoutLast = dropEnd(text, lastLetter);
      result = '${withoutLast}ies';
    } else {
      result = '${t}s';
    }
    return result;
  }
  return null;
}

String firstLetterLower(String text) {
  if (text != null) {
    var t = text.trim();
    if (t == '') {
      return '';
    }
    List<String> letterList = t.split('');
    letterList[0] = letterList[0].toLowerCase();
    String result = '';
    for (String letter in letterList) {
      result = '${result}${letter}';
    }
    return result;
  }
  return null;
}

String firstLetterUpper(String text) {
  if (text != null) {
    var t = text.trim();
    if (t == '') {
      return '';
    }
    List<String> letterList = t.split('');
    letterList[0] = letterList[0].toUpperCase();
    String result = '';
    for (String letter in letterList) {
      result = '${result}${letter}';
    }
    return result;  
  }
  return null;
}

String camelCaseSeparator(String text, String separator) {
  if (text != null) {
    var t = text.trim();
    if (t == '') {
      return '';
    }
    RegExp exp = new RegExp(r"([A-Z])");
    Iterable<Match> matches = exp.allMatches(t);
    var indexes = new List<int>();
    for (Match m in matches) {
      indexes.add(m.end);
    };
    int previousIndex = 0;
    var camelCaseWordList = new List<String>();
    for (int index in indexes) {
      String camelCaseWord = t.substring(previousIndex, index - 1);
      camelCaseWordList.add(camelCaseWord);
      previousIndex = index - 1;
    }
    String camelCaseWord = t.substring(previousIndex);
    camelCaseWordList.add(camelCaseWord);

    String previousCamelCaseWord;
    String result = '';
    for (String camelCaseWord in camelCaseWordList) {
      if (camelCaseWord == '') {
        previousCamelCaseWord = camelCaseWord;
      } else {
        if (previousCamelCaseWord == '') {
          result = '${result}${camelCaseWord}';
        } else {
          result = '${result}${separator}${camelCaseWord}';
        }
        previousCamelCaseWord = camelCaseWord;
      }
    }
    return result;
  }
  return null;
}

String camelCaseLowerSeparator(String text, String separator) {
  var result = camelCaseSeparator(text, separator);
  if (result == null) return null; 
  else return result.toLowerCase();
}

String camelCaseFirstLetterUpperSeparator(String text, String separator) {
  var result = camelCaseSeparator(text, separator);
  if (result == null) return null; 
  else return firstLetterUpper(result);
}