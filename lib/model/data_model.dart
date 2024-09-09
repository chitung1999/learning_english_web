import 'dart:collection';

class WordItem {
  List<String> keys = [];
  List<String> means = [];
  String note = '';


  String keysToString() {
    String key = '';
    for (String str in keys) {
      key += ((key.isEmpty ? '' : ', ') + str);
    }
    return key;
  }

  String meansToString() {
    String mean = '';
    for (String str in means) {
      mean += ((mean.isEmpty ? '' : ', ') + str);
    }
    return mean;
  }
}

class GrammarItem {
  String form = '';
  String structure = '';
}

final dataModel = DataModel();

class DataModel {

  DataModel._internal();

  factory DataModel() {
    return _instance;
  }

  static final DataModel _instance = DataModel._internal();

  SplayTreeMap<String, List<int>> eng = SplayTreeMap<String, List<int>>();
  SplayTreeMap<String, List<int>> vn = SplayTreeMap<String, List<int>>();
  List<WordItem> word = [];
  List<GrammarItem> grammar = [];

  void reset() {
    eng.clear();
    vn.clear();
    word.clear();
    grammar.clear();
  }

  void loadData(var jsonData) {
    reset();

    // Load New word to App
    int index = 0;
    for (Map<String, dynamic> item in jsonData["words"]) {
      WordItem wordItem = WordItem();

      for (String str in item['keys']) {
        if (eng.containsKey(str)) {
          eng[str]!.add(index);
        } else {
          eng[str] = [index];
        }
        wordItem.keys.add(str);
      }

      for (String str in item['means']) {
        if (vn.containsKey(str)) {
          vn[str]!.add(index);
        } else {
          vn[str] = [index];
        }
        wordItem.means.add(str);
      }

      wordItem.note = item['notes'];
      word.add(wordItem);
      index++;
    }

    print(eng);

    // Load grammar to App
    for (Map<String, dynamic> item in jsonData["grammar"]) {
      GrammarItem grammarItem = GrammarItem();
      grammarItem.form = item["form"];
      grammarItem.structure = item["structure"];
      grammar.add(grammarItem);
    }
  }
}