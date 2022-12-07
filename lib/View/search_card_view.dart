import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/search_card_controller.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/View/follow_view.dart';
import 'package:instacopy2/View/profile_view.dart';

class SearchCardView extends StatefulWidget {
  List<String>? preLoadedListOfSearch;
  String? actualSelectedSearchTab;
  String? actualProfileKey;

  SearchCardView(
      {Key? key,
      this.preLoadedListOfSearch,
      this.actualSelectedSearchTab,
      this.actualProfileKey})
      : super(key: key);

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
          padding: const EdgeInsets.all(4.0),
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
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: FutureBuilder(
              future: searchUsersByInputText(),
              builder: (context, snapshot) {
                if (snapshot.data != null &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<UsersModel> searchUsersList =
                      snapshot.data as List<UsersModel>;
                  searchUsersList.sort(
                    (a, b) =>
                        b.followedBy.length.compareTo(a.followedBy.length),
                  );
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchUsersList.length,
                    itemBuilder: (context, index) {
                      return showUserCard(context, searchUsersList[index]);
                    },
                  );
                }
                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileView(
              profileUserId: searchUser.keyFromUser,
            ),
          ),
        );
      },
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(32),
                  child: FutureBuilder(
                      future: getProfileImageUrlWith(
                          searchUser.profileImageReference),
                      builder: (context, snapshotFromProfileImage) {
                        if (snapshotFromProfileImage.data != null &&
                            snapshotFromProfileImage.connectionState ==
                                ConnectionState.done) {
                          String profileImageUrl =
                              snapshotFromProfileImage.data as String;
                          return ApplicationController()
                              .setProfileImageFrom(profileImageUrl.toString());
                        }
                        return CircularProgressIndicator();
                      }),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      maxLines: 1,
                      text: TextSpan(
                          text: searchUser.username,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: ' '),
                            !hasLoggedUserFollowing(searchUser) &&
                                    widget.actualSelectedSearchTab ==
                                        FOLLOWED_BY &&
                                    widget.actualProfileKey ==
                                        ApplicationController()
                                            .getLoggedUserId()
                                ? followAccount(searchUser.keyFromUser)
                                : TextSpan(),
                          ]),
                    ),
                    Text(
                      searchUser.fullname,
                      maxLines: 1,
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
            widget.actualSelectedSearchTab != null
                ? quickActionButton(searchUser)
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<String> getProfileImageUrlWith(String reference) async {
    return await _searchCardController.getProfileImageUrlWith(reference);
  }

  void followSelectedUserBy(String userKey) async {
    await _searchCardController.followUserBy(userKey);
  }

  void unfollowSelectedUserBy(String userKey) async {
    await _searchCardController.unfollowUserBy(userKey);
  }

  void removeFollowerBy(String userKey) async {
    await _searchCardController.removeFollowerBy(userKey);
  }

  TextSpan followAccount(String userKey) {
    return TextSpan(
      text: 'Seguir',
      style: TextStyle(
        color: Colors.blue,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          followSelectedUserBy(userKey);
        },
    );
  }

  bool hasLoggedUserFollowing(UsersModel user) {
    for (String key in user.followedBy) {
      if (key == ApplicationController().getLoggedUserId()) {
        return true;
      }
    }
    return false;
  }

  Widget quickActionButton(UsersModel user) {
    if (widget.actualSelectedSearchTab == FOLLOWED_BY &&
        widget.actualProfileKey == ApplicationController().getLoggedUserId()) {
      return removeThisFollowerButton(user);
    }
    if (widget.actualSelectedSearchTab != null &&
        user.keyFromUser != ApplicationController().getLoggedUserId()) {
      return followOrUnfollowButton(user);
    }
    return Container();
  }

  Widget removeThisFollowerButton(UsersModel user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            alertDialogFromRemoveFollower(user.keyFromUser);
          },
          child: Text('Remover')),
    );
  }

  Widget followOrUnfollowButton(UsersModel user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (user.followedBy
              .contains(ApplicationController().getLoggedUserId())) {
            unfollowSelectedUserBy(user.keyFromUser);
          } else {
            followSelectedUserBy(user.keyFromUser);
          }
        },
        child: Text(
          user.followedBy.contains(ApplicationController().getLoggedUserId())
              ? 'Seguindo'
              : 'Seguir',
        ),
      ),
    );
  }

  void alertDialogFromRemoveFollower(String keyFromUser) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remover Seguidor'),
            content: Text('Deseja realmente remover este seguidor?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                ),
              ),
              TextButton(
                onPressed: () {
                  removeFollowerBy(keyFromUser);
                  Navigator.pop(context);
                },
                child: Text(
                  'Remover',
                ),
              ),
            ],
          );
        });
  }
}
