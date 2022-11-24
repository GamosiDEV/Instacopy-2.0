import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/search_card_controller.dart';
import 'package:instacopy2/Model/users_model.dart';

class SearchCardView extends StatefulWidget {
  List<String>? preLoadedListOfSearch;

  SearchCardView({Key? key, this.preLoadedListOfSearch}) : super(key: key);

  @override
  State<SearchCardView> createState() => _SearchCardViewState();
}

class _SearchCardViewState extends State<SearchCardView> {
  TextEditingController _searchTextController = TextEditingController();
  SearchCardController _searchCardController = SearchCardController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: TextField(
              controller: _searchTextController,
              onChanged: (value) {
                setState(() {});
              },
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
          child: Card(
            child: FutureBuilder(
              future: searchUsersByInputText(),
              builder: (context, snapshot) {
                if (snapshot.data != null &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<UsersModel> searchUsersList =
                      snapshot.data as List<UsersModel>;
                  //TODO: AINDA NÃO CONSIGO EXIBIER OS DADOS
                  /*return ListView.builder(
                    itemCount: searchUsersList.length,
                    itemBuilder: (context, index) {
                      return showUserCard(context, searchUsersList[index]);
                    },
                  );*/
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<List<UsersModel>> searchUsersByInputText() async {
    if (widget.preLoadedListOfSearch != null) {
      return await _searchCardController.searchInPreLoadedList(
          widget.preLoadedListOfSearch, _searchTextController.text);
    }
    return await _searchCardController
        .searchInAllUsers(_searchTextController.text);
  }

  Widget showUserCard(BuildContext context, UsersModel searchUser) {
    return Expanded(
      child: Row(
        children: [
          Container(), //Foto
          Column(), //Username(Seguir) e Fullname
          Container(), //Button(Serguir/Seguindo/Remover)
        ],
      ),
    );
  }
}
