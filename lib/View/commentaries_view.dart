import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/commentaries_controller.dart';
import 'package:instacopy2/Model/commentarie_model.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/View/profile_view.dart';

class CommentariesView extends StatefulWidget {
  String uploadKey;

  CommentariesView({Key? key, required this.uploadKey}) : super(key: key);

  @override
  State<CommentariesView> createState() => _CommentariesViewState();
}

class _CommentariesViewState extends State<CommentariesView> {
  TextEditingController _newCommentarieTextFieldController =
      TextEditingController();

  CommentariesController _commentariesController = CommentariesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicação'),
      ),
      body: FutureBuilder(
        future: getUploadData(),
        builder: (context, uploadSnapshot) {
          if (uploadSnapshot.data != null &&
              uploadSnapshot.connectionState == ConnectionState.done) {
            UploadsModel selectedUpload = uploadSnapshot.data as UploadsModel;

            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.0),
                    child: Card(
                      child: FutureBuilder(
                        future: getCommentariesWith(selectedUpload.commentKeys),
                        builder: (context, comment) {
                          if (comment.data != null &&
                              comment.connectionState == ConnectionState.done) {
                            List<CommentarieModel> listOfComments =
                                comment.data as List<CommentarieModel>;
                            listOfComments.sort((a, b) => b
                                .commentLikedBy.length
                                .compareTo(a.commentLikedBy.length));
                            return ListView.builder(
                              itemCount: listOfComments.length,
                              itemBuilder: (context, index) {
                                return getAndShowCommentary(
                                    listOfComments[index]);
                              },
                            );
                          }
                          return Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.0),
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 0.0),
                            child: TextField(
                              controller: _newCommentarieTextFieldController,
                              decoration: const InputDecoration(
                                hintText: 'Digite seu comentario',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () =>
                                sendCommentarieToDatabaseAndRefresh(
                                    selectedUpload),
                            child: Text(
                              'Publicar',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  void sendCommentarieToDatabaseAndRefresh(UploadsModel selectedUpload) {
    uploadCommentarie(selectedUpload).then((value) {
      setState(() {
        _newCommentarieTextFieldController.text = '';
      });
    });
  }

  Future<void> uploadCommentarie(UploadsModel selectedUpload) async {
    await _commentariesController.uploadCommentarie(
        _newCommentarieTextFieldController.text, selectedUpload);
  }

  Widget getAndShowCommentary(CommentarieModel commentarieModel) {
    return FutureBuilder(
      future: getUserFromCommentarieWith(commentarieModel.sendedByKey),
      builder: (context, snapshot) {
        if (snapshot.data != null &&
            snapshot.connectionState == ConnectionState.done) {
          UsersModel user = UsersModel(keyFromUser: '');
          user = snapshot.data as UsersModel;
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FutureBuilder(
                      future: getProfileImageWithReference(user),
                      builder: (context, profileImageSnapshot) {
                        if (profileImageSnapshot != null &&
                            profileImageSnapshot.connectionState ==
                                ConnectionState.done) {
                          String userProfileImage =
                              profileImageSnapshot.data as String;
                          return InkWell(
                              onTap: () {
                                sendToProfile(commentarieModel.sendedByKey);
                              },
                              child: showProfileImageInFeedCard(
                                  context, userProfileImage));
                        }
                        return showProfileImageInFeedCard(context, '');
                      }),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: user.username,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                sendToProfile(commentarieModel.sendedByKey);
                              },
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(commentarieModel.comment),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (hasCommentLiked(commentarieModel)) {
                            removeLikeFrom(commentarieModel);
                          } else {
                            sendLikeFor(commentarieModel);
                          }
                          setState(() {});
                        },
                        icon: hasCommentLiked(commentarieModel)
                            ? Icon(Icons.star)
                            : Icon(Icons.star_border),
                      ),
                      Text(
                        commentarieModel.commentLikedBy.length.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<List<CommentarieModel>> getCommentariesWith(
      List<String> commentKeys) async {
    return await _commentariesController.getCommentariesWith(commentKeys);
  }

  Future<UsersModel> getUserFromCommentarieWith(String userKey) async {
    return await _commentariesController.getUserFromCommentarieWith(userKey);
  }

  Widget showProfileImageInFeedCard(
      BuildContext context, String userProfileImage) {
    return ClipOval(
      child: SizedBox.fromSize(
        size: Size.fromRadius(24),
        child: ApplicationController()
            .setProfileImageFrom(userProfileImage.toString()),
      ),
    );
  }

  void sendToProfile(String profileKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileView(
          profileUserId: profileKey,
        ),
      ),
    );
  }

  Future<String> getProfileImageWithReference(UsersModel user) async {
    if (user.profileImageUrl != null && user.profileImageUrl != '') {
      return user.profileImageUrl;
    }
    return await _commentariesController.getProfileImageWith(user);
  }

  Future<UploadsModel> getUploadData() async {
    return await _commentariesController.getUploadData(widget.uploadKey);
  }

  bool hasCommentLiked(CommentarieModel commentarie) {
    for (String keyFromUser in commentarie.commentLikedBy) {
      if (keyFromUser == ApplicationController().getLoggedUserId()) {
        return true;
      }
    }
    return false;
  }

  void removeLikeFrom(CommentarieModel comment) {
    _commentariesController.removeLikeFrom(comment);
  }

  void sendLikeFor(CommentarieModel comment) {
    _commentariesController.sendLikeFor(comment);
  }
}
