import 'dart:io';

import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class UploadImageController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<void> sendNewImageToStorageAndUploadToDatabase(
      UploadsModel upload, String selectedFilePath) async {
    sendNewUploadToDatabase(upload, selectedFilePath);
  }

  void sendNewUploadToDatabase(
      UploadsModel upload, String selectedFilePath) async {
    File selectedFile = File(selectedFilePath);

    await ApplicationController()
        .compressFile(selectedFile)
        .then((value) => selectedFile = value);

    _firebaseDatabaseController.setIdToUploadAndSendToDatabase(
        upload, selectedFile);
  }
}
