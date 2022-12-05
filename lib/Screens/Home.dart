import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:provider/provider.dart';
import 'package:quotes/Providers/PageProvider.dart';
import 'package:quotes/Providers/SearchQueryProvider.dart';
import 'package:quotes/Widgets/QuotesList.dart';

import '../Widgets/SearchBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int currentPage = 0;

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentPage = Provider.of<PageProvider>(context, listen: true).currentPage;
    Widget list = const Text("list");
    switch (Provider.of<PageProvider>(context, listen: true).currentPage) {
      case 0:
        list = const QuotesByAuthor();
        break;
      case 1:
        list = const QuotesByTag();
        break;
      default:
        list = const FavList();
        break;
    }
    return Scaffold(
      body: Center(
        child: DraggableHome(
          title: Text((currentPage == 0)
              ? "Quotes by author"
              : currentPage == 1
                  ? "Quotes by tag"
                  : "Liked"),
          headerWidget: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.36,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Author",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w700),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        Provider.of<PageProvider>(context, listen: false)
                            .setPage(0);
                        // Provider.of<SearchQueryProvider>(context, listen: false)
                        //     .clearQuery();
                      });
                      log(Provider.of<PageProvider>(context, listen: false)
                          .currentPage
                          .toString());
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.36,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Tags",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w700),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        Provider.of<PageProvider>(context, listen: false)
                            .setPage(1);
                        // Provider.of<SearchQueryProvider>(context, listen: false)
                        //     .clearQuery();
                      });
                      log(Provider.of<PageProvider>(context, listen: false)
                          .currentPage
                          .toString());
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        Provider.of<PageProvider>(context, listen: false)
                            .setPage(2);
                      });
                    },
                  ),
                ],
              ),
              if (Provider.of<PageProvider>(context, listen: true)
                      .currentPage !=
                  2)
                const SearchBar(),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          body: [list],
        ),
      ),
    );
  }
}
