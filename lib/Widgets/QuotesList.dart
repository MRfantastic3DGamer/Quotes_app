import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quotes/Widgets/QuotePage.dart';
import 'package:quotes/providers/SearchQueryProvider.dart';
import 'package:input_slider/input_slider.dart';

import '../Model/QuoteModel.dart';
import '../Providers/FavoritesProvider.dart';
import '../Providers/QuotesProvider.dart';
import 'QuoteTile.dart';

class QuotesByAuthor extends StatefulWidget {
  const QuotesByAuthor({super.key});

  @override
  State<QuotesByAuthor> createState() => _QuotesByAuthorState();
}

class _QuotesByAuthorState extends State<QuotesByAuthor> {
  @override
  Widget build(BuildContext context) {
    String searchQuery =
        Provider.of<SearchQueryProvider>(context, listen: true).query;
    List<Quote> quotes = Provider.of<QuotesProvider>(context, listen: false)
        .quotesByAuthor(searchQuery);
    if (!context.read<QuotesProvider>().allQuotesLoaded) {
      context.watch<QuotesProvider>().fetchQuotes();
      return Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
          Text("Loading.."),
        ],
      );
    }
    if (quotes.length <= 0) {
      return Text("No Data");
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: InfiniteScrollTabView(
        contentLength: quotes.length,
        tabBuilder: ((index, isSelected) {
          return Text(quotes[index].author);
        }),
        pageBuilder: (context, index, isSelected) {
          return QuotePage(quote: quotes[index]);
        },
      ),
    );
  }
}

class FavList extends StatefulWidget {
  const FavList({super.key});

  @override
  State<FavList> createState() => _FavListState();
}

List<Quote> list = [];

class _FavListState extends State<FavList> {
  // context.watch<FavoritesProvider>();
  late List<String> ss;
  @override
  Widget build(BuildContext context) {
    list = Provider.of<FavoritesProvider>(context, listen: true).quotes;
    // ss = context.read<FavoritesProvider>().s;
    return Column(
      children: [
        ...list
            .map((e) => QuoteTile(quote: e, like: false, delete: true))
            .toList(),
      ],
    );
    // Container();
  }
}

class QuotesByTag extends StatefulWidget {
  const QuotesByTag({super.key});

  @override
  State<QuotesByTag> createState() => _QuotesByTagState();
}

int count = 10;
int i = 0;

class _QuotesByTagState extends State<QuotesByTag> {
  @override
  Widget build(BuildContext context) {
    String searchQuery =
        Provider.of<SearchQueryProvider>(context, listen: true).query;
    List<Quote> quotes = Provider.of<QuotesProvider>(context, listen: false)
        .quotesWithTag(searchQuery);
    if (!context.read<QuotesProvider>().allQuotesLoaded) {
      context.watch<QuotesProvider>().fetchQuotes();
      return Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
          Text("Loading.."),
        ],
      );
    }

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (i >= count) {
                            i -= count;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.chevron_left_sharp,
                        size: 45,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: InputSlider(
                      filled: true,
                      decimalPlaces: 0,
                      onChange: (v) {
                        setState(() {
                          count = v.toInt();
                        });
                      },
                      min: 1,
                      max: 100,
                      defaultValue: 10,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (i < quotes.length - count) {
                            i += count;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.chevron_right_sharp,
                        size: 45,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                primary: false,
                children: [
                  ...quotes.sublist(i, min(i + count, quotes.length)).map(
                      (e) => QuoteTile(quote: e, like: true, delete: false))
                ],
              ),
            ),
          ],
        ));
  }
}
