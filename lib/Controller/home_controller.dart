import 'package:instacopy2/Controller/firebase_database_controller.dart';

class HomeController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<void> logoutUser() async {
    await _firebaseDatabaseController.signOutFromLoggedUser();
  }
}
