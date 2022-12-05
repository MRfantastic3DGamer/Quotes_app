import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../Model/QuoteModel.dart';
import 'package:http/http.dart' as http;

class QuotesProvider with ChangeNotifier {
  final _allQuotesURL =
      'https://api.quotable.io/search/quotes?query=life%20happiness';
  bool _allQuotesLoaded = false;
  List<String> _tags = [];
  bool get allQuotesLoaded => _allQuotesLoaded;
  List<Quote> _allQuotes = [];
  List<Quote> _searchedQuotes = [];

  List<Quote> quotesWithTag(tag) {
    _searchedQuotes.clear();
    for (Quote quote in _allQuotes) {
      for (String t in quote.tags) {
        if (t.toLowerCase().contains(tag.toLowerCase())) {
          log(quote.id);
          _searchedQuotes.add(quote);
        }
      }
    }
    notifyListeners();
    return _searchedQuotes;
  }

  List<Quote> quotesByAuthor(String author) {
    _searchedQuotes.clear();
    for (Quote quote in _allQuotes) {
      if (quote.author.toLowerCase().contains(author.toLowerCase())) {
        _searchedQuotes.add(quote);
      }
    }
    notifyListeners();
    return _searchedQuotes;
  }

  List<Quote> get allQuotes {
    return _allQuotes;
  }

  int get quotesCount => _allQuotesLoaded ? _allQuotes.length : 0;

  void fetchQuotes() async {
    log("message");
    var response = await http.get(Uri.parse(_allQuotesURL));
    if (response.statusCode == 200) {
      _allQuotesLoaded = true;
      var quotesJSON = json.decode(response.body);
      int count = quotesJSON["count"];
      var quotes = quotesJSON["results"];
      for (int i = 0; i < count; i++) {
        _allQuotes.add(Quote.fromJson(quotes[i]));
        // for( Quote q in quotes){
        //   for(String t in  q.tags){
        //     if(!_tags.contains(t)){
        //       _tags.add(t);
        //     }
        //   }
        // }
      }
      notifyListeners();
    }
  }
}
