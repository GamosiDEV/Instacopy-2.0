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
  String uploadImageUrl = '';

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
      FIRESTORE_DATABASE_UPLOADS_UPLOAD_IMAGE_URL: uploadImageUrl,
      FIRESTORE_DATABASE_UPLOADS_UPLOADER_KEY: uploaderKey
    };
  }

  void setUserModelWith(Map<String, dynamic>? uploadModelMap) {
    if (uploadModelMap != null) {
      this.keyFromUpload = uploadModelMap[FIRESTORE_DATABASE_UPLOADS_KEY];

      this.commentKeys =
          (uploadModelMap[FIRESTORE_DATABASE_UPLOADS_COMMENT_KEYS] as List)
              .map((item) => item as String)
              .toList();

      this.description = uploadModelMap[FIRESTORE_DATABASE_UPLOADS_DESCRIPTION];

      this.likedBy =
          (uploadModelMap[FIRESTORE_DATABASE_UPLOADS_LIKED_BY] as List)
              .map((item) => item as String)
              .toList();

      this.savedBy =
          (uploadModelMap[FIRESTORE_DATABASE_UPLOADS_SAVED_BY] as List)
              .map((item) => item as String)
              .toList();

      this.uploadDateTime =
          uploadModelMap[FIRESTORE_DATABASE_UPLOADS_UPLOAD_DATE_TIME];
      this.uploadStorageReference =
          uploadModelMap[FIRESTORE_DATABASE_UPLOADS_UPLOAD_STORAGE_REFERENCE];
      if (uploadModelMap[FIRESTORE_DATABASE_UPLOADS_UPLOAD_IMAGE_URL] != null) {
        this.uploadImageUrl =
            uploadModelMap[FIRESTORE_DATABASE_UPLOADS_UPLOAD_IMAGE_URL];
      }

      this.uploaderKey =
          uploadModelMap[FIRESTORE_DATABASE_UPLOADS_UPLOADER_KEY];
    }
  }
}
