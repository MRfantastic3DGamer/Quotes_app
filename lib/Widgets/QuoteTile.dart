import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/Providers/FavoritesProvider.dart';

import '../Model/QuoteModel.dart';

class QuoteTile extends StatelessWidget {
  late Quote quote;
  late bool like, delete;
  QuoteTile(
      {super.key,
      required this.quote,
      required this.like,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(
                            quote.content,
                            maxLines: 100,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "~${quote.author}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (like)
                    IconButton(
                      onPressed: () {
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .createItem(quote);
                        const SnackBar(
                          content: Text("added to favorites"),
                          duration: Duration(milliseconds: 300),
                        );
                      },
                      icon: const Icon(Icons.favorite),
                    ),
                  if (delete)
                    IconButton(
                      onPressed: () {
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .deleteItem(quote);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("removed from favorites"),
                          duration: Duration(milliseconds: 300),
                        ));
                      },
                      icon: const Icon(Icons.delete),
                    )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                quote.tags.toString(),
                style: const TextStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
