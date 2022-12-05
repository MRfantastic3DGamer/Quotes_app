import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/SearchQueryProvider.dart';


class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

String query = "";

class _SearchBarState extends State<SearchBar> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: query);
    return Center(
      child: Container(
        height: 65,
        // width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 121, 171, 236),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            focusNode: focusNode,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            controller: searchController,
            decoration: const InputDecoration(
              icon: Icon(Icons.search, color: Colors.white, size: 30),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onSubmitted: (s) {
              query = s;
              focusNode.unfocus();
            },
            onChanged: (s) {
              query = s;
              Provider.of<SearchQueryProvider>(context, listen: false).changeQuery(s);
            },
          ),
        ),
      ),
    );
  }
}
