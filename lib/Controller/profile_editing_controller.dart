import 'package:instacopy2/Controller/firebase_database_controller.dart';

class ProfileEditingController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<String> getUrlFromProfileImageWith(
      String profileImageReference) async {
    return await _firebaseDatabaseController
        .getDownloadUrlFrom(profileImageReference);
  }
}
