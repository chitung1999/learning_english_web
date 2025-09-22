import 'package:flutter/material.dart';

enum TypeWord {
  normal,
  add,
  remove
}

class Data {
  String word = '';
  TypeWord type = TypeWord.normal;

  Data(String w, TypeWord t) {
    word = w;
    type = t;
  }
}

class DataApp with ChangeNotifier {
  final List<Data> _data = [];

  void addWord(String word) {
    _data.insert(0, Data(word, TypeWord.add));
    notifyListeners();
  }

  void removeWord(int index) {
    if (_data[index].type == TypeWord.normal) {
      _data[index].type = TypeWord.remove;
    } else if (_data[index].type == TypeWord.add) {
      _data.removeAt(index);
    }
    notifyListeners();
  }

  void unRemoveWord(int index) {
    _data[index].type = TypeWord.normal;
    notifyListeners();
  }

  void initData(List<String> words) {
    _data.clear();
    for (var item in words) {
      _data.add(Data(item, TypeWord.normal));
    }
    notifyListeners();
  }

  List<String> getListStringData() {
    List<String> words = [];
    for (var item in _data) {
      if (item.type != TypeWord.remove) {
        words.add(item.word);
      }
    }

    return words;
  }

  bool checkExist(String word) {
    Set<String> words = _data.map((item) => item.word).toSet();
    return words.contains(word);
  }

  List<Data> getData() {return _data;}
}
