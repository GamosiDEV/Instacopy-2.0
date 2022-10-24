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
      body: Center(
        child: [
          TabFeedView(
            loggedUserId: getLoggedUserId(),
          ),
          TabSearchView(
            loggedUserId: getLoggedUserId(),
          ),
          TabProfileView(
            profileUserId: getLoggedUserId(),
            loggedUserId: getLoggedUserId(),
          ),
        ].elementAt(_selectedIndex),
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
            icon: Icon(Icons.account_circle),
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
    });
  }

  void changeAppBarTitle(String newTitle) {
    setState(() {
      appBarTitle = newTitle;
    });
  }

  String? getLoggedUserId() {
    return _homeController.getLoggedUserId();
  }
}
