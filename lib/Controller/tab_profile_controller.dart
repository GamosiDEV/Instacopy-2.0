import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';

class TabProfileController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileUserData(
      String userId) async {
    return await _firebaseDatabaseController.getProfileUserData(userId);
  }

  Future<String> getProfileImageUrlFrom(UsersModel user) {
    return _firebaseDatabaseController.getProfileImageUrlFrom(user);
  }

  Future<List<UploadsModel>> getUploadsBy(List<String> uploads) async {
    return await _firebaseDatabaseController.getUploadsAndDonwloadUrl(uploads);
  }

  Future<void> followUserBy(String userKey) async {
    return await _firebaseDatabaseController.followUserBy(userKey);
  }

  Future<void> unfollowUserBy(String userKey) async {
    return await _firebaseDatabaseController.unfollowUserBy(userKey);
  }
}
