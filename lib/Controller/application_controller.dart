import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/View/login_view.dart';

class ApplicationController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  static void showSnackBar(String snackBarText, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        snackBarText,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void logout(BuildContext context) {
    _firebaseDatabaseController.signOutFromLoggedUser().then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }
}
