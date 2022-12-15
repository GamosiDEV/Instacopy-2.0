import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/users_model.dart';

class ProfileEditingController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<String> getUrlFromProfileImageWith(UsersModel user) async {
    return await _firebaseDatabaseController.getProfileImageUrlFrom(user);
  }

  Future<void> updateProfileImage(
      String newProfileImage, String profileImageReference) async {
    await _firebaseDatabaseController.updadeProfileImage(
        newProfileImage, profileImageReference);
  }

  Future<void> updateProfileData(UsersModel updateUser) async {
    await _firebaseDatabaseController.updadeProfileData(updateUser);
  }
}
