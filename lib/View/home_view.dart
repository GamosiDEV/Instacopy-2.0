import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/application_controller.dart';
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
  String? loggedUserId = ApplicationController().getLoggedUserId();

  int _selectedIndex = 0;
  String appBarTitle = 'Instacopy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: [
          TabFeedView(
            loggedUserId: loggedUserId,
          ),
          TabSearchView(
            loggedUserId: loggedUserId,
          ),
          TabProfileView(
            profileUserId: loggedUserId,
            loggedUserId: loggedUserId,
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
}
/**

Container(
    width: 1080,
    height: 384,
    child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Container(
                width: 1080,
                height: 384,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            width: 345,
                            height: 247.21,
                            child: Stack(
                                children: [
                                    Positioned(
                                        left: 72.48,
                                        top: 11.71,
                                        child: Container(
                                            width: 190.38,
                                            height: 197,
                                            decoration: ShapeDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment(0.00, -1.00),
                                                    end: Alignment(0, 1),
                                                    colors: [Color(0xFF2196F4), Color(0xFF43174E)],
                                                ),
                                                shape: OvalBorder(),
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        ],
    ),
)

 */
