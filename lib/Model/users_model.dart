import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class UsersModel {
  String keyFromUser;
  String email;
  String username;
  String fullname;
  String bio = '';
  Timestamp birthDate = Timestamp.now();
  List<String> commentsSended = [];
  List<String> followedBy = [];
  List<String> followerOf = [];
  String genere = '';
  List<String> likesInComments = [];
  List<String> likesInUploads = [];
  String myLinks = '';
  String profileImageReference = '';
  List<String> savedPosts = [];
  List<String> userUploads = [];

  UsersModel(
      {required this.keyFromUser,
      this.email = '',
      this.username = '',
      this.fullname = ''});

  Map<String, dynamic> getMapFromThisModel() {
    return {
      FIRESTORE_DATABASE_USERS_DOCUMENT_KEY: keyFromUser,
      FIRESTORE_DATABASE_USERS_DOCUMENT_EMAIL: email,
      FIRESTORE_DATABASE_USERS_DOCUMENT_USERNAME: username,
      FIRESTORE_DATABASE_USERS_DOCUMENT_FULLNAME: fullname,
      FIRESTORE_DATABASE_USERS_DOCUMENT_BIO: bio,
      FIRESTORE_DATABASE_USERS_DOCUMENT_BIRTH_DATE: birthDate,
      FIRESTORE_DATABASE_USERS_DOCUMENT_COMMENTS_SENDED: commentsSended,
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWED_BY: followedBy,
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWER_OF: followerOf,
      FIRESTORE_DATABASE_USERS_DOCUMENT_GENERE: genere,
      FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_COMMENTS: likesInComments,
      FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_UPLOADS: likesInUploads,
      FIRESTORE_DATABASE_USERS_DOCUMENT_MY_LINKS: myLinks,
      FIRESTORE_DATABASE_USERS_DOCUMENT_PROFILE_IMAGE_REFERENCE:
          profileImageReference,
      FIRESTORE_DATABASE_USERS_DOCUMENT_SAVED_POSTS: savedPosts,
      FIRESTORE_DATABASE_USERS_DOCUMENT_USER_UPLOADS: userUploads
    };
  }
}
