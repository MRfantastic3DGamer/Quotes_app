import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quotes/Model/QuoteModel.dart';

late Box favs;
List<Quote> _quotes = [];

class FavoritesProvider with ChangeNotifier {
  UnmodifiableListView<Quote> get quotes => UnmodifiableListView(_quotes);
  final String quoteHiveBox = 'quote-box';

  // Create new quote
  Future<void> createItem(Quote quote) async {
    getItems();
    log("createItem");
    Box<Quote> box = await Hive.openBox<Quote>(quoteHiveBox);
    if (!quotes.contains(quote)) {
      await box.add(quote);
      _quotes.add(quote);
      _quotes = box.values.toList();
      notifyListeners();
    }
  }

// remove a note
  Future<void> deleteItem(Quote quote) async {
    getItems();
    Box<Quote> box = await Hive.openBox<Quote>(quoteHiveBox);
    await box.delete(quote.key);
    _quotes = box.values.toList();
    notifyListeners();
  }

  // Get quote
  Future<void> getItems() async {
    log("get items");
    Box<Quote> box = await Hive.openBox<Quote>(quoteHiveBox);
    _quotes = box.values.toList();
    notifyListeners();
  }
}
