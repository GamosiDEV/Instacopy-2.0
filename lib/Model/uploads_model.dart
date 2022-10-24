import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class UploadsModel {
  String keyFromUpload = '';
  List<String> commentKeys = [];
  String description;
  List<String> likedBy = [];
  List<String> savedBy = [];
  Timestamp uploadDateTime;
  String uploadStorageReference = '';
  String uploaderKey;

  UploadsModel(this.description, this.uploadDateTime, this.uploaderKey);

  Map<String, dynamic> getMapFromThisModel() {
    return {
      FIRESTORE_DATABASE_UPLOADS_KEY: keyFromUpload,
      FIRESTORE_DATABASE_UPLOADS_COMMENT_KEYS: commentKeys,
      FIRESTORE_DATABASE_UPLOADS_DESCRIPTION: description,
      FIRESTORE_DATABASE_UPLOADS_LIKED_BY: likedBy,
      FIRESTORE_DATABASE_UPLOADS_SAVED_BY: savedBy,
      FIRESTORE_DATABASE_UPLOADS_UPLOAD_DATE_TIME: uploadDateTime,
      FIRESTORE_DATABASE_UPLOADS_UPLOAD_STORAGE_REFERENCE:
          uploadStorageReference,
      FIRESTORE_DATABASE_UPLOADS_UPLOADER_KEY: uploaderKey
    };
  }
}
