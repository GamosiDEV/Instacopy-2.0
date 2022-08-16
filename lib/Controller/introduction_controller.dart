import 'package:instacopy2/Controller/firebase_database_controller.dart';

class IntroductionController {
  late FirebaseDatabaseController _firebaseDatabaseController;

  IntroductionController() {
    this._firebaseDatabaseController = FirebaseDatabaseController();
  }

  bool hasLoggedUser() {
    if (_firebaseDatabaseController.hasLogged())
      return true;
    else
      return false;
  }
}
