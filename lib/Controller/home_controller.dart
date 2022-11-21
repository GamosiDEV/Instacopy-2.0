import 'package:instacopy2/Controller/firebase_database_controller.dart';

class HomeController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  bool hasNull(String userId) {
    if (userId == null) {
      return true;
    }
    return false;
  }
}
