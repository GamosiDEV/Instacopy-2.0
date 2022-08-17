import 'package:instacopy2/Controller/firebase_database_controller.dart';

class LoginController {
  late FirebaseDatabaseController _firebaseDatabaseController;

  LoginController() {
    this._firebaseDatabaseController = FirebaseDatabaseController();
  }

  bool loginUserWithEmailAndPassword(String email, String password) {
    bool hasLogged = false;
    _firebaseDatabaseController.login(email, password).then((value) {
      if (value == FirebaseDatabaseController.FIREBASE_SUCCESSFUL_LOGIN) {
        return true;
      }
    });
    return hasLogged;
  }
}
