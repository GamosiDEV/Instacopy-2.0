import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/application_controller.dart';

class TabSearchView extends StatefulWidget {
  final String? loggedUserId;
  const TabSearchView({Key? key, required this.loggedUserId}) : super(key: key);

  @override
  State<TabSearchView> createState() => _TabSearchViewState();
}

class _TabSearchViewState extends State<TabSearchView> {
  ApplicationController _applicationController = ApplicationController();

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
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Sair da Pesquisa'),
            ),
          ],
        ),
      ),
    );
  }

  void toUploadImageView() {
    _applicationController.toUploadImageView(context, widget.loggedUserId);
  }
}
