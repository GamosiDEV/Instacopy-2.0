import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class CommentariesController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<void> uploadCommentarie(String comment, UploadsModel upload) async {
    await _firebaseDatabaseController.uploadCommentarie(comment, upload);
  }
}

