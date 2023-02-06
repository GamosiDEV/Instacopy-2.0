import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/upload_card_feed_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/View/commentaries_view.dart';
import 'package:instacopy2/View/home_view.dart';
import 'package:instacopy2/View/profile_view.dart';
import 'package:instacopy2/View/upload_editor_view.dart';
import 'package:share_plus/share_plus.dart';

class UploadCardFeedView extends StatefulWidget {
  UploadsModel? upload;
  UsersModel? profileUser;
  String? userProfileImage;
  String uploadKey;
  String userUploaderKey;
  String loggedUserKey;

  UploadCardFeedView(
      {Key? key,
      this.upload,
      this.profileUser,
      this.userProfileImage,
      required this.uploadKey,
      required this.userUploaderKey,
      required this.loggedUserKey})
      : super(key: key);

  @override
  State<UploadCardFeedView> createState() => _UploadCardFeedViewState();
}

class _UploadCardFeedViewState extends State<UploadCardFeedView> {
  UploadCardFeedController _uploadCardFeedController =
      UploadCardFeedController();

  bool showMoreDescription = false;
  UploadsModel? upload;
  UsersModel? profileUser;
  String? userProfileImage;
  String? imageShareUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      upload = widget.upload;
      profileUser = widget.profileUser;
      userProfileImage = widget.userProfileImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: FutureBuilder(
          future: profileUser != null ? null : getProfileUserWithKey(),
          builder: (context, profileSnapshot) {
            if (profileUser != null) {
              return showFutureCardWithUploadUserInformation(context);
            } else if (profileSnapshot != null &&
                profileSnapshot.connectionState == ConnectionState.done) {
              profileUser = profileSnapshot.data as UsersModel;
              return showFutureCardWithUploadUserInformation(context);
            }
            return Card(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }

  Widget showFutureCardWithUploadUserInformation(BuildContext context) {
    return Card(
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
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
            child: Row(
              children: [
                Container(
                  height: 32,
                  alignment: Alignment.center,
                  child: FutureBuilder(
                      future: userProfileImage != null
                          ? null
                          : getProfileImageWithReference(),
                      builder: (context, profileImageSnapshot) {
                        if (userProfileImage != null) {
                          return showProfileImageInFeedCard(context);
                        } else if (profileImageSnapshot != null &&
                            profileImageSnapshot.connectionState ==
                                ConnectionState.done) {
                          userProfileImage =
                              profileImageSnapshot.data as String;
                          return showProfileImageInFeedCard(context);
                        }
                        return Image.asset('assets/images/profile.jpg');
                      }),
                ),
                Container(
                  height: 32,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      sendToProfile();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0.0),
                      child: Text(
                        profileUser!.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Spacer(), //TODO: mostrar opções de ação para este card (Icons.more_vert)
                hasUploadFromLoggedUser()
                    ? PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 0,
                              child: Text('Editar descriçao'),
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: Text('Excluir'),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              editUpload();
                              break;
                            case 1:
                              deleteUpload();
                              break;
                          }
                        },
                      )
                    : const IconButton(
                        onPressed: null, icon: Icon(Icons.more_vert))
              ],
            ),
          ),
          FutureBuilder(
            future: upload != null ? null : getUploadDataWithUploadKey(),
            builder: (context, uploadSnapshot) {
              if (upload != null) {
                return showUploadDataInCard(context);
              } else if (uploadSnapshot != null &&
                  uploadSnapshot.connectionState == ConnectionState.done) {
                upload = uploadSnapshot.data as UploadsModel;
                return showUploadDataInCard(context);
              }
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget showProfileImageInFeedCard(BuildContext context) {
    return InkWell(
      onTap: () {
        sendToProfile();
      },
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(18),
          child: ApplicationController()
              .setProfileImageFrom(userProfileImage.toString()),
        ),
      ),
    );
  }

  Widget showUploadDataInCard(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: getUploadImageUrl(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String imageUrl = snapshot.data.toString();
              imageShareUrl = imageUrl;
              return Container(
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.center,
                        image: NetworkImage(imageUrl))),
              );
            }
            return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.65,
                child: CircularProgressIndicator());
          },
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setLikeToUpload();
              },
              icon: hasLiked()
                  ? const Icon(
                      Icons.star,
                    )
                  : const Icon(
                      Icons.star_border,
                    ),
            ),
            IconButton(
              onPressed: () {
                setSaveToUpload();
              },
              icon: hasSaved()
                  ? Icon(
                      Icons.save_rounded,
                    )
                  : Icon(
                      Icons.save_outlined,
                    ),
            ),
            IconButton(
              onPressed: () {
                shareUpload();
              },
              icon: Icon(
                Icons.send,
              ),
            ),
            Spacer(),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            upload!.likedBy.length.toString() + " curtidas",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: RichText(
            maxLines: showMoreDescription ? 50 : 3,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            text: TextSpan(
              text: profileUser!.username + '  ',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  sendToProfile();
                },
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text: upload!.description,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        changeShowMoreDescriptionState();
                      }),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: RichText(
            text: TextSpan(
                text: 'Ver todos os comentários',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black45),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showAllCommentaries();
                  }),
          ),
        ),
      ],
    );
  }

  void sendToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileView(
          profileUserId: widget.userUploaderKey,
        ),
      ),
    );
  }

  Future<String> getUploadImageUrl() async {
    if (upload!.uploadImageUrl != null && upload!.uploadImageUrl != '') {
      return upload!.uploadImageUrl;
    }
    return await _uploadCardFeedController.getImageUrlBy(upload!);
  }

  void setLikeToUpload() {
    setState(() {
      if (hasLiked()) {
        removeLikeToDatabase();
        upload!.likedBy.remove(widget.loggedUserKey);
      } else {
        sendLikeToDatabase();
        upload!.likedBy.add(widget.loggedUserKey);
      }
    });
  }

  void setSaveToUpload() {
    setState(() {
      if (hasSaved()) {
        removeSaveToDatabase();
        upload!.savedBy.remove(widget.loggedUserKey);
      } else {
        sendSaveToDatabase();
        upload!.savedBy.add(widget.loggedUserKey);
      }
    });
  }

  void shareUpload() {
    if (imageShareUrl != null) {
      Share.share(imageShareUrl.toString());
    }
  }

  void showAllCommentaries() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentariesView(
          uploadKey: upload!.keyFromUpload,
        ),
      ),
    );
  }

  void changeShowMoreDescriptionState() {
    setState(() {
      if (showMoreDescription) {
        showMoreDescription = false;
      } else {
        showMoreDescription = true;
      }
    });
  }

  Future<UsersModel> getProfileUserWithKey() async {
    return await _uploadCardFeedController
        .getProfileUserWith(widget.userUploaderKey);
  }

  Future<String> getProfileImageWithReference() async {
    if (profileUser!.profileImageUrl != null &&
        profileUser!.profileImageUrl != '') {
      return profileUser!.profileImageUrl;
    }
    return await _uploadCardFeedController.getProfileImageWith(profileUser!);
  }

  Future<UploadsModel> getUploadDataWithUploadKey() async {
    return await _uploadCardFeedController.getUploadDataWith(widget.uploadKey);
  }

  bool hasLiked() {
    for (String keyFromUser in upload!.likedBy) {
      if (keyFromUser == widget.loggedUserKey) {
        return true;
      }
    }
    return false;
  }

  bool hasSaved() {
    for (String keyFromUser in upload!.savedBy) {
      if (keyFromUser == widget.loggedUserKey) {
        return true;
      }
    }
    return false;
  }

  Future<void> sendLikeToDatabase() async {
    await _uploadCardFeedController.sendLikeStatusToDatabase(
        upload!.keyFromUpload, widget.loggedUserKey);
  }

  Future<void> removeLikeToDatabase() async {
    await _uploadCardFeedController.removeLikeToDatabase(
        upload!.keyFromUpload, widget.loggedUserKey);
  }

  Future<void> sendSaveToDatabase() async {
    await _uploadCardFeedController.sendSaveToDatabase(
        upload!.keyFromUpload, widget.loggedUserKey);
  }

  Future<void> removeSaveToDatabase() async {
    await _uploadCardFeedController.removeSaveToDatabase(
        upload!.keyFromUpload, widget.loggedUserKey);
  }

  bool hasUploadFromLoggedUser() {
    if (widget.userUploaderKey == widget.loggedUserKey) {
      return true;
    }
    return false;
  }

  void editUpload() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadEditorView(upload: upload!),
      ),
    ).whenComplete(() {
      Navigator.of(context).pop();
    });

    //TODO: SEND TO EDIT UPLOAD VIEW
  }

  void deleteUpload() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Excluir Postagem'),
            content: Text('Deseja realmente excluir esta postagem?'),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Cancelar',
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteUploadFromDatabase();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Excluir',
                ),
              ),
            ],
          );
        }).whenComplete(() {
      Navigator.of(context).pop();
    });
  }

  void deleteUploadFromDatabase() {
    if (upload != null) {
      _uploadCardFeedController
          .deleteUploadFromDatabase(upload!)
          .whenComplete(() {});
    }
  }
}
