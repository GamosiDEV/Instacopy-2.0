import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/View/home_feed_view.dart';

class LoginController {
  late FirebaseDatabaseController _firebaseDatabaseController;
  ValueNotifier<bool> hasEmailValid = ValueNotifier<bool>(true);
  ValueNotifier<bool> hasPasswordValid = ValueNotifier<bool>(true);
  //bool hasEmailValid = true;
  //bool hasPasswordValid = true;

  LoginController() {
    _firebaseDatabaseController = FirebaseDatabaseController();
  }

  void _resetSignUpValidation() {
    hasEmailValid.value = true;
    hasPasswordValid.value = true;
  }

  void loginUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    _resetSignUpValidation();
    await _firebaseDatabaseController
        .signInWithEmailAndPassword(email, password)
        .then((value) {
      if (value == FirebaseDatabaseController.FIREBASE_SUCCESSFUL_LOGIN) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeFeedView()));
      } else if (value == FirebaseDatabaseController.FIREBASE_EMAIL_NOT_FOUND) {
        hasEmailValid.value = false;
      } else if (value == FirebaseDatabaseController.FIREBASE_WRONG_PASSWORD) {
        hasPasswordValid.value = false;
      }
    });
  }
}
