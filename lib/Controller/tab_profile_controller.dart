import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/users_model.dart';

class TabProfileController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileUserData(
      String userId) async {
    return await _firebaseDatabaseController.getProfileUserData(userId);
  }

  Future<String> getProfileImageUrlFrom(String imageReference) {
    return _firebaseDatabaseController.getProfileImageUrlFrom(imageReference);
  }
}
