import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/application_controller.dart';

class TabFeedView extends StatefulWidget {
  const TabFeedView({Key? key}) : super(key: key);

  @override
  State<TabFeedView> createState() => _TabFeedViewState();
}

class _TabFeedViewState extends State<TabFeedView> {
  ApplicationController _applicationController = ApplicationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instacopy'),
        actions: [
          IconButton(
            onPressed: () {},
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
              child: const Text('Sair da Home'),
            ),
          ],
        ),
      ),
    );
  }
}
