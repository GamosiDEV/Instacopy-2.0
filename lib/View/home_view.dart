import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Controller/home_controller.dart';
import 'package:instacopy2/Theme/app_colors.dart';
import 'package:instacopy2/View/tab_feed_view.dart';
import 'package:instacopy2/View/login_view.dart';
import 'package:instacopy2/View/tab_profile_view.dart';
import 'package:instacopy2/View/tab_search_view.dart';

class HomeFeedView extends StatefulWidget {
  const HomeFeedView({Key? key}) : super(key: key);

  @override
  State<HomeFeedView> createState() => _HomeFeedViewState();
}

class _HomeFeedViewState extends State<HomeFeedView>
    with TickerProviderStateMixin {
  HomeController _homeController = HomeController();

  int _selectedIndex = 0;
  String appBarTitle = 'Instacopy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: [TabFeedView(), TabSearchView(), TabProfileView()]
            .elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        elevation: 10.0,
        backgroundColor: AppColors.secondaryBackgroundColor,
        unselectedItemColor: AppColors.darkBackgroundAssentColor,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          appBarTitle = 'Instacopy';
          break;
        case 1:
          appBarTitle = 'Instacopy';
          break;
        case 2:
          appBarTitle = 'Username';
          break;
      }
    });
  }

  void logout() {
    _homeController.logoutUser().then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }
}