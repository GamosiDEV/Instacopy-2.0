import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/View/upload_card_feed_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UserUploadFeedView extends StatefulWidget {
  List<UploadsModel> listOfUploads;
  UsersModel? profileUser;
  String? userProfileImage;
  String userUploaderKey;
  String loggedUser;
  int indexOfUpload;

  UserUploadFeedView(
      {Key? key,
      required this.listOfUploads,
      required this.loggedUser,
      required this.userUploaderKey,
      this.profileUser,
      this.userProfileImage,
      required this.indexOfUpload})
      : super(key: key);

  @override
  State<UserUploadFeedView> createState() => _UserUploadFeedViewState();
}

class _UserUploadFeedViewState extends State<UserUploadFeedView> {
  ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicações'),
      ),
      body: ScrollablePositionedList.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        initialScrollIndex: widget.indexOfUpload,
        itemScrollController: _scrollController,
        itemCount: widget.listOfUploads.length,
        itemBuilder: (context, index) {
          return UploadCardFeedView(
            uploadKey: widget.listOfUploads[index].keyFromUpload,
            userUploaderKey: widget.listOfUploads[index].uploaderKey,
            loggedUserKey: widget.loggedUser,
          );
        },
      ),
    );
  }
}
