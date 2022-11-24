import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/View/followed_by_view.dart';
import 'package:instacopy2/View/follower_of_view.dart';
import 'package:instacopy2/View/search_card_view.dart';

class FollowView extends StatefulWidget {
  final int initialIndex;
  final UsersModel actualProfileData;

  const FollowView(
      {Key? key, required this.initialIndex, required this.actualProfileData})
      : super(key: key);

  @override
  State<FollowView> createState() => _FollowViewState();
}

class _FollowViewState extends State<FollowView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.actualProfileData.username),
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.actualProfileData.followedBy.length.toString() +
                      ' Seguidores',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.actualProfileData.followerOf.length.toString() +
                      ' Seguindo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchCardView(
                preLoadedListOfSearch: widget.actualProfileData.followedBy),
            SearchCardView(
                preLoadedListOfSearch: widget.actualProfileData.followerOf),
          ],
        ),
      ),
    );
  }
}
