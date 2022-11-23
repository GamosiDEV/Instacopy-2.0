import 'package:instacopy2/Controller/firebase_database_controller.dart';

class UploadEditorController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  void updateDescription(String keyFromUpload, String newDescription) {
    _firebaseDatabaseController.updateDescription(
        keyFromUpload, newDescription);
  }
}
