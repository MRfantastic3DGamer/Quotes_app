import 'package:flutter/material.dart';

class SearchQueryProvider with ChangeNotifier {
  String _query = "";
  String get query => _query;
  void changeQuery(String s){
    _query = s;
    notifyListeners();
  }
  void clearQuery(){
    _query = "";
    notifyListeners();
  }
}