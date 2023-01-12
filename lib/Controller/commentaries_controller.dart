import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';
import 'package:instacopy2/Model/commentarie_model.dart';

class CommentariesController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<void> uploadCommentarie(String comment, UploadsModel upload) async {
    await _firebaseDatabaseController.uploadCommentarie(comment, upload);
  }

  Future<List<CommentarieModel>> getCommentariesWith(
      List<String> commentKeys) async {
    return await _firebaseDatabaseController.getCommentariesWith(commentKeys);
  }

  Future<UsersModel> getUserFromCommentarieWith(String userKey) async {
    return await _firebaseDatabaseController
        .getProfileUserData(userKey)
        .then((userSnapshot) {
      UsersModel user = UsersModel(keyFromUser: '');
      user.setUserModelWith(userSnapshot.data());
      return user;
    });
  }

  Future<String> getProfileImageWith(UsersModel user) async {
    return await _firebaseDatabaseController.getProfileImageUrlFrom(user);
  }

  Future<UploadsModel> getUploadData(String uploadKey) async {
    return await _firebaseDatabaseController
        .getUploadDataWith(uploadKey)
        .then((uploadSnapshot) {
      UploadsModel upload = UploadsModel('', Timestamp.now(), '');
      upload.setUserModelWith(uploadSnapshot.data());
      return upload;
    });
  }

  void removeLikeFrom(CommentarieModel comment) {
    _firebaseDatabaseController.removeLikeFrom(comment);
  }

  void sendLikeFor(CommentarieModel comment) {
    _firebaseDatabaseController.sendLikeFor(comment);
  }

  Future<void> deleteCommentarieFromDatabase(
      CommentarieModel commentarieModel) async {
    return _firebaseDatabaseController
        .deleteCommentarieFromDatabase(commentarieModel);
  }
}
