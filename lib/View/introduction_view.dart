import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Controller/introduction_controller.dart';
import 'package:instacopy2/Theme/app_colors.dart';
import 'package:instacopy2/View/home_feed_view.dart';
import 'package:instacopy2/View/login_view.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  late IntroductionController introductionController;
  late FirebaseDatabaseController firebaseDatabaseController;

  @override
  void initState() {
    super.initState();

    introductionController = IntroductionController();
    firebaseDatabaseController = FirebaseDatabaseController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      verificadorDeUsuarioLogado(this.context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.introductionBackgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Instacopy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 72.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verificadorDeUsuarioLogado(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5), () {
      if (introductionController.hasLoggedUser()) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeFeedView()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      }
    });
  }
}
