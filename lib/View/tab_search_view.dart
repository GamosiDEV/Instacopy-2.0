import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/View/home_view.dart';
import 'package:instacopy2/View/search_card_view.dart';

class TabSearchView extends StatefulWidget {
  final String? loggedUserId;
  const TabSearchView({Key? key, required this.loggedUserId}) : super(key: key);

  @override
  State<TabSearchView> createState() => _TabSearchViewState();
}

class _TabSearchViewState extends State<TabSearchView> {
  final ApplicationController _applicationController = ApplicationController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //  Navigator.pushReplacement(context,
        //      MaterialPageRoute(builder: (context) => const HomeFeedView()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instacopy'),
          actions: [
            IconButton(
              onPressed: toUploadImageView,
              icon: const Icon(Icons.add_a_photo),
            ),
            IconButton(
              onPressed: () => _applicationController.logout(context),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SearchCardView(),
      ),
    );
  }

  void toUploadImageView() {
    _applicationController.toUploadImageView(context, widget.loggedUserId);
  }
}
