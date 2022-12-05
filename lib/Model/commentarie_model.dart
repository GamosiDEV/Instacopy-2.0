import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class CommentarieModel {
  String keyFromComment;
  String sendedByKey;
  String keyFromUpload;
  String comment;
  List<String> commentLikedBy = [];

  CommentarieModel({
    required this.keyFromComment,
    required this.sendedByKey,
    required this.keyFromUpload,
    required this.comment,
  });

  Map<String, dynamic> getMapFromThisModel() {
    return {
      FIRESTORE_DATABASE_COMMENTARIES_COMMENT_KEY: keyFromComment,
      FIRESTORE_DATABASE_COMMENTARIES_SENDED_BY: sendedByKey,
      FIRESTORE_DATABASE_COMMENTARIES_KEY_FROM_COMMENT_UPLOAD: keyFromUpload,
      FIRESTORE_DATABASE_COMMENTARIES_COMMENT: comment,
      FIRESTORE_DATABASE_COMMENTARIES_COMMENT_LIKED_BY: commentLikedBy,
    };
  }

  void setUserModelWith(Map<String, dynamic>? commentModelMap) {
    if (commentModelMap != null) {
      keyFromComment =
          commentModelMap[FIRESTORE_DATABASE_COMMENTARIES_COMMENT_KEY];
      sendedByKey = commentModelMap[FIRESTORE_DATABASE_COMMENTARIES_SENDED_BY];
      keyFromUpload = commentModelMap[
          FIRESTORE_DATABASE_COMMENTARIES_KEY_FROM_COMMENT_UPLOAD];
      comment = commentModelMap[FIRESTORE_DATABASE_COMMENTARIES_COMMENT];

      commentLikedBy =
          (commentModelMap[FIRESTORE_DATABASE_COMMENTARIES_COMMENT_LIKED_BY]
                  as List)
              .map((item) => item as String)
              .toList();
    }
  }
}
