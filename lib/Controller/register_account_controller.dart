import 'package:flutter/cupertino.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';

class RegisterAccountController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  void signUpNewAccount(BuildContext context, String email, String fullname,
      String username, String password) {
    String newAccountId = _firebaseDatabaseController
        .signUpWithEmailAndPassword(email, password)
        .then((value) {
      if (value != null) {
        return value;
      }
      return '000';
    }) as String;

    _firebaseDatabaseController.createNewAccountInUserCollection(
        newAccountId, email, fullname, username);
  }
}
