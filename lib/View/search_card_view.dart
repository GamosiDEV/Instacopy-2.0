import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchCardView extends StatefulWidget {
  List<String>? preLoadedListOfSearch;

  SearchCardView({Key? key, this.preLoadedListOfSearch}) : super(key: key);

  @override
  State<SearchCardView> createState() => _SearchCardViewState();
}

class _SearchCardViewState extends State<SearchCardView> {
  TextEditingController _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: TextField(
              controller: _searchTextController,
              onSubmitted: null,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: 'Pesquisar',
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Expanded(
            child: Card(
              child: FutureBuilder(
                future: widget.preLoadedListOfSearch != null ? null : null,
                builder: (context, snapshot) {
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
