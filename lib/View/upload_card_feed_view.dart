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
  UploadsModel upload;
  UsersModel profileUser;
  String userProfileImage;

  UploadCardFeedView(
      {Key? key,
      required this.upload,
      required this.profileUser,
      required this.userProfileImage})
      : super(key: key);

  @override
  State<UploadCardFeedView> createState() => _UploadCardFeedViewState();
}

class _UploadCardFeedViewState extends State<UploadCardFeedView> {
  UploadCardFeedController _uploadCardFeedController =
      UploadCardFeedController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      sendToProfile();
                    },
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(18),
                        child: ApplicationController()
                            .setProfileImageFrom(widget.userProfileImage),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      sendToProfile();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0.0),
                      child: Text(
                        widget.profileUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
              child: FutureBuilder(
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
                      child: const CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IconButton(
                      onPressed: () {
                        sendlikeToUpload();
                      },
                      icon: Icon(
                        Icons.star_border,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IconButton(
                      onPressed: () {
                        saveUpload();
                      },
                      icon: Icon(
                        Icons.save_outlined,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IconButton(
                      onPressed: () {
                        shareUpload();
                      },
                      icon: Icon(
                        Icons.send,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RichText(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: widget.profileUser.username + '  ',
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
                        text: widget.upload.description,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
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
        ),
      ),
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
        .getImageUrlBy(widget.upload.uploadStorageReference);
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
}
