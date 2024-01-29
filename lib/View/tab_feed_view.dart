import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/tab_feed_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/View/upload_card_feed_view.dart';
import 'package:instacopy2/View/user_upload_feed_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TabFeedView extends StatefulWidget {
  final String? loggedUserId;
  const TabFeedView({Key? key, required this.loggedUserId}) : super(key: key);

  @override
  State<TabFeedView> createState() => _TabFeedViewState();
}

class _TabFeedViewState extends State<TabFeedView> {
  ApplicationController _applicationController = ApplicationController();
  TabFeedController _tabFeedController = TabFeedController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instacopy'),
        actions: [
          IconButton(
            onPressed: toUploadImageView,
            icon: Icon(Icons.add_a_photo),
          ),
          IconButton(
            onPressed: () => _applicationController.logout(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: getListOfPostForFeed(),
          builder: (context, feedSnapshot) {
            if (feedSnapshot != null &&
                feedSnapshot.connectionState == ConnectionState.done) {
              List<UploadsModel> listOfPosts =
                  feedSnapshot.data as List<UploadsModel>;
              if (listOfPosts.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tente procurar e seguir novos usuarios na aba de "Pesquisar" para popular seu feed !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              listOfPosts.sort(
                (a, b) => b.likedBy.length.compareTo(a.likedBy.length),
              );
              listOfPosts.sort(
                (a, b) => b.uploadDateTime.compareTo(a.uploadDateTime),
              );
              listOfPosts.sort(((a, b) {
                if (a.uploaderKey == b.uploaderKey) {
                  return -1;
                }
                return 0;
              }));
              return RefreshIndicator(
                onRefresh: pullToRefresh,
                child: ScrollablePositionedList.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  itemCount: listOfPosts.length,
                  itemBuilder: (context, index) {
                    return UploadCardFeedView(
                      uploadKey: listOfPosts[index].keyFromUpload,
                      userUploaderKey: listOfPosts[index].uploaderKey,
                      loggedUserKey: widget.loggedUserId!,
                    );
                  },
                ),
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
    );
  }

  void toUploadImageView() {
    _applicationController.toUploadImageView(context, widget.loggedUserId);
  }

  Future<List<UploadsModel>> getListOfPostForFeed() async {
    return await _tabFeedController.getListOfPostForFeed();
  }

  Future<void> pullToRefresh() async {
    setState(() {});
  }
}
