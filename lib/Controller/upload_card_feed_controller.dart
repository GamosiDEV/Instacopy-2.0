import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class UploadCardFeedController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<String> getImageUrlBy(UploadsModel upload) async {
    return await _firebaseDatabaseController.getImageUrlBy(upload);
  }

  Future<UsersModel> getProfileUserWith(String userKey) async {
    return await _firebaseDatabaseController
        .getProfileUserData(userKey)
        .then((userSnapshot) {
      UsersModel user = UsersModel(
          keyFromUser:
              userSnapshot.data()![FIRESTORE_DATABASE_USERS_DOCUMENT_KEY]);
      user.setUserModelWith(userSnapshot.data());
      return user;
    });
  }

  Future<String> getProfileImageWith(UsersModel user) async {
    return await _firebaseDatabaseController.getProfileImageUrlFrom(user);
  }

  Future<UploadsModel> getUploadDataWith(String uploadKey) async {
    return await _firebaseDatabaseController
        .getUploadDataWith(uploadKey)
        .then((uploadDataSnapshot) {
      UploadsModel upload = UploadsModel(
          uploadDataSnapshot.data()![FIRESTORE_DATABASE_UPLOADS_DESCRIPTION],
          uploadDataSnapshot
              .data()![FIRESTORE_DATABASE_UPLOADS_UPLOAD_DATE_TIME],
          uploadDataSnapshot.data()![FIRESTORE_DATABASE_UPLOADS_KEY]);
      upload.setUserModelWith(uploadDataSnapshot.data());
      return upload;
    });
  }

  Future<void> sendLikeStatusToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseDatabaseController.sendLikeStatusToDatabase(
        uploadKey, likedByUserKey);
  }

  Future<void> removeLikeToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseDatabaseController.removeLikeToDatabase(
        uploadKey, likedByUserKey);
  }

  Future<void> sendSaveToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseDatabaseController.sendSaveToDatabase(
        uploadKey, likedByUserKey);
  }

  Future<void> removeSaveToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseDatabaseController.removeSaveToDatabase(
        uploadKey, likedByUserKey);
  }

  Future<void> deleteUploadFromDatabase(UploadsModel upload) async {
    await _firebaseDatabaseController.deleteUploadFromDatabase(upload);
  }
}
