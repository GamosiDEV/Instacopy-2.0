import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/View/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Instacopy'),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                floating: true,
                pinned: true,
                bottom: TabBar(
                  tabs: [
                    Tab(text: "Posts"),
                    Tab(text: "Likes"),
                  ],
                ),
                expandedHeight: 450,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode
                      .pin, // This is where you build the profile part
                ),
              ),
            ];
          },
          body: TabBarView(children: [getHome(), getProfile()]),
        ),
      ),
    );
  }

  Widget getHome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            FirebaseDatabaseController().signOutFromLoggedUser();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginView()));
          },
          child: const Text('Sair da Home'),
        ),
      ],
    );
  }

  Widget getProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            FirebaseDatabaseController().signOutFromLoggedUser();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginView()));
          },
          child: const Text('Sair do Perfil'),
        ),
      ],
    );
  }
}
