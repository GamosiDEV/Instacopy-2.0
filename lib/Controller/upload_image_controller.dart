import 'dart:io';

import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class UploadImageController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<void> sendNewImageToStorageAndUploadToDatabase(
      UploadsModel upload, String selectedFilePath) async {
    sendNewUploadToDatabase(upload, selectedFilePath);
  }

  void sendNewUploadToDatabase(UploadsModel upload, String selectedFilePath) {
    File selectedFile = File(selectedFilePath);
    _firebaseDatabaseController.setIdToUploadAndSendToDatabase(
        upload, selectedFile);
  }
}
