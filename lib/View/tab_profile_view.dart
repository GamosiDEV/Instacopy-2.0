import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';

class TabProfileView extends StatefulWidget {
  final String profileUserId;
  const TabProfileView({Key? key, required this.profileUserId})
      : super(key: key);

  @override
  State<TabProfileView> createState() => _TabProfileViewState();
}

class _TabProfileViewState extends State<TabProfileView> {
  ApplicationController _applicationController = ApplicationController();
  String numberOfPosts = '11';
  String numberOfFollowers = '283';
  String numberAreFollowing = '733';
  String fullname = 'Gabriel de Moura Silva';
  String bio = 'asdasd\ndasdasd\ndasdasd\ndasdasdas';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
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
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
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
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(6.0, 6.0, 14.0, 0),
                                    child: CircleAvatar(
                                      radius: 42.0,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          numberOfPosts,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Text('Publicações'),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          numberOfFollowers,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Text('Seguidores'),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          numberAreFollowing,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Text('Seguindo'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    fullname,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    bio,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ElevatedButton(
                                        onPressed: onEditProfileButtonPressed,
                                        child: Text(
                                          'Editar perfil',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Seguir',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
            child: Card(
              elevation: 10.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: <Widget>[
                  TabBar(
                    labelColor: Colors.blueAccent,
                    tabs: [
                      Tab(child: Icon(Icons.photo)),
                      Tab(child: Icon(Icons.save)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 3,
                          children: Colors.primaries.map((color) {
                            return Container(color: color, height: 150.0);
                          }).toList(),
                        ),
                        GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 3,
                          children: Colors.primaries.map((color) {
                            return Container(color: color, height: 150.0);
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onEditProfileButtonPressed() {
    setState(() {
      username = 'Meu nome';
    });
  }
}
