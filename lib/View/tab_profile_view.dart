import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/tab_profile_controller.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/View/upload_image_view.dart';

class TabProfileView extends StatefulWidget {
  final String? profileUserId;
  final String? loggedUserId;
  const TabProfileView(
      {Key? key, required this.profileUserId, required this.loggedUserId})
      : super(key: key);

  @override
  State<TabProfileView> createState() => _TabProfileViewState();
}

class _TabProfileViewState extends State<TabProfileView> {
  ApplicationController _applicationController = ApplicationController();
  TabProfileController _tabProfileController = TabProfileController();
  String numberOfPosts = '11';
  String numberOfFollowers = '283';
  String numberAreFollowing = '733';
  String fullname = 'Gabriel de Moura Silva';
  String bio = 'asdasd\ndasdasd\ndasdasd\ndasdasdas';

  UsersModel usersModel = UsersModel(keyFromUser: '');
  GlobalKey keyFromUploadedImageCard = new GlobalKey();

  String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProfileUserDataByUserId(),
        builder: (context, snapshotFromUserModel) {
          if (snapshotFromUserModel.connectionState == ConnectionState.done ||
              snapshotFromUserModel.data != null) {
            setSnapshotDataToUserModel(snapshotFromUserModel);
            return Scaffold(
              appBar: AppBar(
                title: Text(usersModel.username),
                actions: [
                  IconButton(
                    onPressed: widget.profileUserId == widget.loggedUserId
                        ? toUploadImageView
                        : null,
                    icon: Icon(Icons.add_a_photo),
                  ),
                  IconButton(
                    onPressed: () => _applicationController.logout(context),
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
              body: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 10.0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                6.0, 6.0, 14.0, 0),
                                            child: ClipOval(
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(42),
                                                child: profileImageUrl != null
                                                    ? setProfileImageFrom(
                                                        profileImageUrl
                                                            .toString())
                                                    : FutureBuilder(
                                                        future:
                                                            getProfileImageUrl(),
                                                        builder: (context,
                                                            snapshotFromProfileImage) {
                                                          if (snapshotFromProfileImage
                                                                      .data !=
                                                                  null &&
                                                              snapshotFromProfileImage
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .done) {
                                                            profileImageUrl =
                                                                snapshotFromProfileImage
                                                                        .data
                                                                    as String;
                                                            return setProfileImageFrom(
                                                                profileImageUrl
                                                                    .toString());
                                                          }
                                                          return CircularProgressIndicator();
                                                        }),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              final contextFromKey =
                                                  keyFromUploadedImageCard
                                                      .currentContext;
                                              if (contextFromKey != null) {
                                                Scrollable.ensureVisible(
                                                  contextFromKey,
                                                  duration: const Duration(
                                                      milliseconds: 400),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    usersModel
                                                        .userUploads.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                  Text('Publicações'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  usersModel.followedBy.length
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0),
                                                ),
                                                Text('Seguidores'),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  usersModel.followerOf.length
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0),
                                                ),
                                                Text('Seguindo'),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          12.0, 4.0, 0.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            usersModel.fullname,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            usersModel.bio,
                                            maxLines: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4.0),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          !hasTheLoggedUserProfile()
                                              ? Container()
                                              : Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'Editar perfil',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          hasTheLoggedUserProfile()
                                              ? Container()
                                              : Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (hasProfileFollowedByLoggedUser()) {
                                                          print(
                                                              'Deixar de seguir');
                                                          //TODO-metodo para deixar de seguir
                                                        } else {
                                                          print('Seguir');
                                                          //TODO-metodo para seguir
                                                        }
                                                      },
                                                      child: Text(
                                                        hasProfileFollowedByLoggedUser()
                                                            ? 'Deixar de Seguir'
                                                            : 'Seguir',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    key: keyFromUploadedImageCard,
                    padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                    child: Card(
                      elevation: 10.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            labelColor: Colors.blueAccent,
                            tabs: [
                              Tab(child: Icon(Icons.photo)),
                              Tab(child: Icon(Icons.save)),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                GridView.count(
                                  padding: EdgeInsets.zero,
                                  crossAxisCount: 3,
                                  children: Colors.primaries.map((color) {
                                    return Container(
                                        color: color, height: 150.0);
                                  }).toList(),
                                ),
                                GridView.count(
                                  padding: EdgeInsets.zero,
                                  crossAxisCount: 3,
                                  children: Colors.primaries.map((color) {
                                    return Container(
                                        color: color, height: 150.0);
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      getProfileUserDataByUserId() async {
    return await _tabProfileController
        .getProfileUserData(widget.profileUserId.toString());
  }

  void setSnapshotDataToUserModel(final snapshot) {
    var DocData = snapshot.data as DocumentSnapshot;
    Map<String, dynamic> mapFromSnapshotData =
        DocData.data() as Map<String, dynamic>;
    usersModel.setUserModelWith(mapFromSnapshotData);
  }

  Future<String> getProfileImageUrl() {
    return _tabProfileController
        .getProfileImageUrlFrom(usersModel.profileImageReference);
  }

  Widget setProfileImageFrom(String url) {
    return FadeInImage(
      image: url == ''
          ? placeHolderProfileImage()
          : NetworkImage(
              url,
            ),
      placeholder: placeHolderProfileImage(),
    );
  }

  ImageProvider placeHolderProfileImage() {
    return const AssetImage('assets/images/profile.jpg');
  }

  bool hasTheLoggedUserProfile() {
    if (widget.loggedUserId == widget.profileUserId) {
      return true;
    }
    return false;
  }

  bool hasProfileFollowedByLoggedUser() {
    if (usersModel.followedBy.contains(widget.loggedUserId)) {
      return true;
    }
    return false;
  }

  void toUploadImageView() {
    _applicationController.toUploadImageView(context, widget.loggedUserId);
  }
}
