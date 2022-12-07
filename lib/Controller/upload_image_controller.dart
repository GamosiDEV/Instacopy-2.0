import 'dart:io';

import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class UploadImageController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();
/*
  void sendNewImageToStorageAndUploadToDatabase (UploadsModel upload, String selectedFilePath) {
    sendImageToStorageAndGetReference(selectedFilePath, upload.uploaderKey)
        .then((newImageReference) {
      upload.uploadStorageReference = newImageReference;
      sendNewUploadToDatabase(upload);
    });
  }*/

  void sendNewImageToStorageAndUploadToDatabase(
      UploadsModel upload, String selectedFilePath) {
    sendNewUploadToDatabase(upload, selectedFilePath);
  }
/*
  Future<String> sendImageToStorageAndGetReference(
      String selectedFilePath, String uploaderId) async {
    File selectedFile = File(selectedFilePath);

    return await _firebaseDatabaseController
        .sendImageToStorageAndGetReference(selectedFile, upload)
        .then((reference) {
      return reference;
    });
  }*/

  void sendNewUploadToDatabase(UploadsModel upload, String selectedFilePath) {
    File selectedFile = File(selectedFilePath);
    _firebaseDatabaseController.setIdToUploadAndSendToDatabase(
        upload, selectedFile);
  }
}
