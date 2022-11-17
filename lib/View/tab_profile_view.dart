import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/tab_profile_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/View/follow_view.dart';
import 'package:instacopy2/View/profile_editing_view.dart';
import 'package:instacopy2/View/upload_card_feed_view.dart';
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
                                                    ? ApplicationController()
                                                        .setProfileImageFrom(
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
                                                            return ApplicationController()
                                                                .setProfileImageFrom(
                                                                    profileImageUrl
                                                                        .toString());
                                                          }
                                                          return CircularProgressIndicator();
                                                        }),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: scrollScreenToUploadsCard,
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
                                          InkWell(
                                            onTap: () {
                                              navigateToFollowView(0);
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
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              navigateToFollowView(1);
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
                                                      onPressed: () {
                                                        moveToProfileEditingView();
                                                      },
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
                                FutureBuilder(
                                    future: getUploadsFromUserBy(
                                        usersModel.userUploads),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState !=
                                              ConnectionState.done ||
                                          snapshot.data == null) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      List<UploadsModel> profileUploads =
                                          snapshot.data as List<UploadsModel>;
                                      return showOnGrid(profileUploads);
                                    }),
                                FutureBuilder(
                                    future: getUploadsFromUserBy(
                                        usersModel.savedPosts),
                                    builder: (context, snapshot01) {
                                      if (snapshot01.connectionState !=
                                              ConnectionState.done ||
                                          snapshot01.data == null) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      List<UploadsModel> profileUploads =
                                          snapshot01.data as List<UploadsModel>;
                                      return showOnGrid(profileUploads);
                                    }),
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

  void scrollScreenToUploadsCard() {
    final contextFromKey = keyFromUploadedImageCard.currentContext;
    if (contextFromKey != null) {
      Scrollable.ensureVisible(
        contextFromKey,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void navigateToFollowView(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FollowView(
                  initialIndex: index,
                  actualProfileData: usersModel,
                )));
  }

  Widget showOnGrid(List<UploadsModel> uploads) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemCount: uploads.length,
      itemBuilder: (context, index) {
        uploads
            .sort((m1, m2) => m2.uploadDateTime.compareTo(m1.uploadDateTime));
        if (index < uploads.length) {
          return GestureDetector(
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.center,
                    image: NetworkImage(
                      uploads[index].downloadedImageURL,
                    ),
                  ),
                ),
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadCardFeedView(
                    upload: uploads[index],
                    profileUser: usersModel,
                    userProfileImage: profileImageUrl ?? '',
                    userUploaderKey: usersModel.keyFromUser,
                    uploadKey: uploads[index].keyFromUpload,
                  ),
                ),
              );
              //TODO: Enviar para a tela de feed do perfil, aquela lista scrollavel
              //que exibe todas as fotos da pessoa
            },
          );
        }
        return Container();
      },
    );
  }

  Future<List<UploadsModel>> getUploadsFromUserBy(List<String> uploads) async {
    return await _tabProfileController.getUploadsBy(uploads);
  }

  void moveToProfileEditingView() async {
    bool? hasUpdated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileEditingView(
          userModel: usersModel,
        ),
      ),
    );

    if (hasUpdated != null && hasUpdated) {
      ApplicationController.showSnackBar(
          'Perfil foi atualizado com sucesso', context);
      setState(() {});
    }
  }
}
