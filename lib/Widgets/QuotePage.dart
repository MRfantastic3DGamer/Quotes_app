import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/Providers/FavoritesProvider.dart';

import '../Model/QuoteModel.dart';
import 'QuoteTile.dart';

class QuotePage extends StatefulWidget {
  late Quote quote;
  QuotePage({super.key, required this.quote});

  @override
  State<QuotePage> createState() => _QuotePageState(quote: quote);
}

class _QuotePageState extends State<QuotePage> {
  late Quote quote;
  _QuotePageState({required this.quote});
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Text(
            quote.content,
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<FavoritesProvider>(context, listen: false)
                      .createItem(quote);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Added to favorites"),
                    duration: Duration(milliseconds: 300),
                  ));
                },
                icon: const Icon(Icons.favorite_outlined),
              )
            ],
          )
        ],
      ),
    );
  }
}
