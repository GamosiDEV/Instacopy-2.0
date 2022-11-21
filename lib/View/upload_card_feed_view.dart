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
                Spacer(),
                IconButton(
                  onPressed: () {
                    //TODO: mostrar opções de ação para este card
                  },
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.more_vert),
                ),
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
                sendlikeToUpload();
              },
              icon: Icon(
                Icons.star_border,
              ),
            ),
            IconButton(
              onPressed: () {
                saveUpload();
              },
              icon: Icon(
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
          child: Expanded(
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
    //TODO:
    print('==============');
    print('==To Profile==');
    print('==============');
  }

  Future<String> getUploadImageUrl() async {
    return await _uploadCardFeedController
        .getImageUrlBy(upload!.uploadStorageReference);
  }

  void sendlikeToUpload() {
    //TODO:
    print('==============');
    print('=====LIKE=====');
    print('==============');
  }

  void saveUpload() {
    //TODO:
    print('==============');
    print('=====SAVE=====');
    print('==============');
  }

  void shareUpload() {
    //TODO:
    print('==============');
    print('=====SHARE====');
    print('==============');
  }

  void showAllCommentaries() {
    //TODO:
    print('==============');
    print('===COMMENTS===');
    print('==============');
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
    return await _uploadCardFeedController
        .getProfileImageWith(profileUser!.profileImageReference);
  }

  Future<UploadsModel> getUploadDataWithUploadKey() async {
    return await _uploadCardFeedController.getUploadDataWith(widget.uploadKey);
  }
}
