// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Model/commentarie_model.dart';
import 'package:instacopy2/Model/uploads_model.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';
import 'package:path/path.dart';

class FirebaseDatabaseController {
  static String FIREBASE_EMAIL_NOT_FOUND = 'user-not-found';
  static String FIREBASE_WRONG_PASSWORD = 'wrong-password';
  static String FIREBASE_SUCCESSFUL_LOGIN = 'successful-login';

  static const String FIREBASE_AUTH_EMAIL_ALREADY_IN_USE_ERROR =
      'email-already-in-use';

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  bool hasLogged() {
    if (_firebaseAuth.currentUser != null) {
      return true;
    }
    return false;
  }

  String? getLoggedUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return FIREBASE_SUCCESSFUL_LOGIN;
    } on FirebaseAuthException catch (e) {
      if (e.code == FIREBASE_WRONG_PASSWORD) {
        return FIREBASE_WRONG_PASSWORD;
      } else {
        return FIREBASE_EMAIL_NOT_FOUND;
      }
    }
  }

  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    String? userCredential = null;
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCredential = value.user?.uid;
    });
    await _firebaseAuth.currentUser?.sendEmailVerification();
    return userCredential;
  }

  Future<void> createNewAccountInUserCollection(UsersModel usersModel) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(usersModel.keyFromUser)
        .set(usersModel.getMapFromThisModel())
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<void> signOutFromLoggedUser() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendForgotPasswordMessage(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendFeedbakcToDatabase(Map<String, dynamic> feedback) async {
    final instance = await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_FEEDBACKS)
        .doc();

    feedback.addAll({FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_KEY: instance.id});

    instance.set(feedback);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileUserData(
      String userId) async {
    return await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(userId)
        .get();
  }

  Future<String> getProfileImageUrlFrom(UsersModel user) async {
    if (user.profileImageReference != null &&
        user.profileImageReference != "") {
      return await _firebaseStorage
          .ref(user.profileImageReference)
          .getDownloadURL()
          .then((imageUrl) async {
        await _firebaseFirestore
            .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
            .doc(user.keyFromUser)
            .update({
          FIRESTORE_DATABASE_USERS_DOCUMENT_PROFILE_IMAGE_URL: imageUrl
        });
        return imageUrl;
      });
    }
    return '';
  }

  Future<String> sendImageToStorageAndGetReference(
      File selectedFile, UploadsModel upload) async {
    String newImageReference = FIREBASE_STORAGE_USERS +
        upload.uploaderKey +
        FIREBASE_STORAGE_USERS_UPLOADS +
        upload.keyFromUpload;

    await _firebaseStorage.ref().child(newImageReference).putFile(
        selectedFile, SettableMetadata(cacheControl: "public, max-age=3600"));

    return newImageReference;
  }

  void setIdToUploadAndSendToDatabase(
      UploadsModel upload, File selectedFile) async {
    final instance = _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc();

    upload.keyFromUpload = instance.id;

    await sendImageToStorageAndGetReference(selectedFile, upload)
        .then((newImageReference) {
      upload.uploadStorageReference = newImageReference;
    });

    instance.set(upload.getMapFromThisModel());

    addIdOfUploadToUser(upload.keyFromUpload, upload.uploaderKey);
  }

  Future<List<UploadsModel>> getUploadsAndDonwloadUrl(
      List<String> listOfKeys) async {
    List<UploadsModel> listOfUploads = [];

    for (String uploadKey in listOfKeys) {
      await _firebaseFirestore
          .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
          .get()
          .then((allUploads) async {
        for (final uploadDataFromDatabase in allUploads.docs) {
          if (uploadKey == uploadDataFromDatabase.id) {
            UploadsModel upload = UploadsModel('', Timestamp.now(), '');
            upload.setUserModelWith(uploadDataFromDatabase.data());
            if (upload.uploadImageUrl == null || upload.uploadImageUrl == '') {
              await getDownloadUrlFrom(upload).then((downloadUrl) {
                upload.uploadImageUrl = downloadUrl.toString();
              });
            }
            listOfUploads.add(upload);
          }
        }
      });
    }

    return listOfUploads;
  }

  Future<String> getDownloadUrlFrom(UploadsModel upload) async {
    return await _firebaseStorage
        .ref()
        .child(upload.uploadStorageReference)
        .getDownloadURL()
        .then((imageUrl) async {
      await _firebaseFirestore
          .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
          .doc(upload.keyFromUpload)
          .update({FIRESTORE_DATABASE_UPLOADS_UPLOAD_IMAGE_URL: imageUrl});
      return imageUrl;
    });
  }

  void addIdOfUploadToUser(String keyFromUpload, String uploaderKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(uploaderKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_USER_UPLOADS:
          FieldValue.arrayUnion([keyFromUpload])
    });
  }

  Future<void> updadeProfileImage(
      String newProfileImage, String profileImageReference) async {
    File newImage = File(newProfileImage);
    await ApplicationController()
        .compressFile(newImage)
        .then((value) => newImage = value);

    if (profileImageReference != getStandardProfileImageReference()) {
      profileImageReference = FIREBASE_STORAGE_USERS +
          getLoggedUserId().toString() +
          FIREBASE_STORAGE_USERS_PROFILE +
          'profile_image';

      setNewProfileImageReferenceToUser(profileImageReference);
    }

    await _firebaseStorage.ref().child(profileImageReference).putFile(
        newImage, SettableMetadata(cacheControl: "public, max-age=3600"));
  }

  String getStandardProfileImageReference() {
    return FIREBASE_STORAGE_USERS +
        getLoggedUserId().toString() +
        FIREBASE_STORAGE_USERS_PROFILE +
        'profile_image';
  }

  Future<void> setNewProfileImageReferenceToUser(
      String profileImageReference) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_PROFILE_IMAGE_REFERENCE:
          profileImageReference
    });
  }

  Future<void> updadeProfileData(UsersModel updadeUser) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(updadeUser.keyFromUser)
        .update(updadeUser.getMapForUpdadeProfile());
  }

  Future<String> getImageUrlBy(UploadsModel uploadsModel) async {
    return await _firebaseStorage
        .ref(uploadsModel.uploadStorageReference)
        .getDownloadURL()
        .then((imageUrl) async {
      await _firebaseFirestore
          .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
          .doc(uploadsModel.keyFromUpload)
          .update({FIRESTORE_DATABASE_UPLOADS_UPLOAD_IMAGE_URL: imageUrl});
      return imageUrl;
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUploadDataWith(
      String uploadId) async {
    return await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(uploadId)
        .get();
  }

  Future<void> sendLikeStatusToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(uploadKey)
        .update({
      FIRESTORE_DATABASE_UPLOADS_LIKED_BY:
          FieldValue.arrayUnion([likedByUserKey])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(likedByUserKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_UPLOADS:
          FieldValue.arrayUnion([uploadKey])
    });
  }

  Future<void> removeLikeToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(uploadKey)
        .update({
      FIRESTORE_DATABASE_UPLOADS_LIKED_BY:
          FieldValue.arrayRemove([likedByUserKey])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(likedByUserKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_UPLOADS:
          FieldValue.arrayRemove([uploadKey])
    });
  }

  Future<void> sendSaveToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(uploadKey)
        .update({
      FIRESTORE_DATABASE_UPLOADS_SAVED_BY:
          FieldValue.arrayUnion([likedByUserKey])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(likedByUserKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_SAVED_POSTS:
          FieldValue.arrayUnion([uploadKey])
    });
  }

  Future<void> removeSaveToDatabase(
      String uploadKey, String likedByUserKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(uploadKey)
        .update({
      FIRESTORE_DATABASE_UPLOADS_SAVED_BY:
          FieldValue.arrayRemove([likedByUserKey])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(likedByUserKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_SAVED_POSTS:
          FieldValue.arrayRemove([uploadKey])
    });
  }

  Future<void> deleteUploadFromDatabase(UploadsModel upload) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(upload.keyFromUpload)
        .delete();

    await _firebaseStorage.ref(upload.uploadStorageReference).delete();

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(upload.uploaderKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_USER_UPLOADS:
          FieldValue.arrayRemove([upload.keyFromUpload])
    });

    var userCollection =
        _firebaseFirestore.collection(FIRESTORE_DATABASE_COLLECTION_USERS);
    var querySnapshots = await userCollection.get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        FIRESTORE_DATABASE_USERS_DOCUMENT_SAVED_POSTS:
            FieldValue.arrayRemove([upload.keyFromUpload])
      });
      await doc.reference.update({
        FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_UPLOADS:
            FieldValue.arrayRemove([upload.keyFromUpload])
      });
    }

    //TODO: Excluir comentarios relacionados ao upload
  }

  void updateDescription(String keyFromUpload, String newDescription) {
    _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(keyFromUpload)
        .update({FIRESTORE_DATABASE_UPLOADS_DESCRIPTION: newDescription});
  }

  Future<List<UsersModel>> searchUsers(String searchString) async {
    List<UsersModel> listOfUsers = [];

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .get()
        .then((allUsers) async {
      for (final user in allUsers.docs) {
        if (user
                .data()[FIRESTORE_DATABASE_USERS_DOCUMENT_USERNAME]
                .toString()
                .contains(searchString) ||
            user
                .data()[FIRESTORE_DATABASE_USERS_DOCUMENT_FULLNAME]
                .toString()
                .contains(searchString) ||
            searchString == '') {
          UsersModel searchedUser = UsersModel(
              keyFromUser: user.data()[FIRESTORE_DATABASE_USERS_DOCUMENT_KEY]);
          searchedUser.setUserModelWith(user.data());
          listOfUsers.add(searchedUser);
        }
      }
    });
    return listOfUsers;
  }

  Future<List<UsersModel>> searchUsersInPreLoadedList(
      String profileUserKey, String searchString, String followListName) async {
    List<UsersModel> listOfUsers = [];
    List<String> listOfFollowersForSearch = [];

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(profileUserKey)
        .get()
        .then((profileUserSnapshot) {
      for (final followOfUser in profileUserSnapshot.data()![followListName]) {
        listOfFollowersForSearch.add(followOfUser.toString());
      }
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .get()
        .then((allUsers) async {
      for (final preLoadedUserKey in listOfFollowersForSearch) {
        for (final user in allUsers.docs) {
          if ((user
                      .data()[FIRESTORE_DATABASE_USERS_DOCUMENT_USERNAME]
                      .toString()
                      .contains(searchString) ||
                  user
                      .data()[FIRESTORE_DATABASE_USERS_DOCUMENT_FULLNAME]
                      .toString()
                      .contains(searchString) ||
                  searchString == '') &&
              user.data()[FIRESTORE_DATABASE_USERS_DOCUMENT_KEY] ==
                  preLoadedUserKey) {
            UsersModel searchedUser = UsersModel(
                keyFromUser:
                    user.data()[FIRESTORE_DATABASE_USERS_DOCUMENT_KEY]);
            searchedUser.setUserModelWith(user.data());
            listOfUsers.add(searchedUser);
          }
        }
      }
    });
    return listOfUsers;
  }

  Future<void> followUserBy(String userKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWER_OF:
          FieldValue.arrayUnion([userKey])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(userKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWED_BY:
          FieldValue.arrayUnion([getLoggedUserId()])
    });
  }

  Future<void> unfollowUserBy(String userKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWER_OF:
          FieldValue.arrayRemove([userKey])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(userKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWED_BY:
          FieldValue.arrayRemove([getLoggedUserId()])
    });
  }

  Future<void> removeFollowerBy(String userKey) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWED_BY:
          FieldValue.arrayRemove([userKey])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(userKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWER_OF:
          FieldValue.arrayRemove([getLoggedUserId()])
    });
  }

  Future<void> uploadCommentarie(String comment, UploadsModel upload) async {
    final instance = await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_COMMENTARIES)
        .doc();

    CommentarieModel commentarieModel = CommentarieModel(
        keyFromComment: instance.id,
        sendedByKey: getLoggedUserId().toString(),
        keyFromUpload: upload.keyFromUpload,
        comment: comment);

    await instance.set(commentarieModel.getMapFromThisModel());

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(commentarieModel.sendedByKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_COMMENTS_SENDED:
          FieldValue.arrayUnion([commentarieModel.keyFromComment])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(commentarieModel.keyFromUpload)
        .update({
      FIRESTORE_DATABASE_UPLOADS_COMMENT_KEYS:
          FieldValue.arrayUnion([commentarieModel.keyFromComment])
    });
  }

  Future<List<CommentarieModel>> getCommentariesWith(
      List<String> commentKeys) async {
    List<CommentarieModel> listOfCommentaries = [];
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_COMMENTARIES)
        .get()
        .then((commentSnapshot) {
      for (final preLoadedCommentKey in commentKeys) {
        for (final commentFromDatabase in commentSnapshot.docs) {
          if (commentFromDatabase
                  .data()[FIRESTORE_DATABASE_COMMENTARIES_COMMENT_KEY] ==
              preLoadedCommentKey) {
            CommentarieModel commentarie = CommentarieModel(
                keyFromComment: '',
                sendedByKey: '',
                keyFromUpload: '',
                comment: '');
            commentarie.setUserModelWith(commentFromDatabase.data());
            listOfCommentaries.add(commentarie);
          }
        }
      }
    });
    return listOfCommentaries;
  }

  Future<void> removeLikeFrom(CommentarieModel comment) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_COMMENTS:
          FieldValue.arrayRemove([comment.keyFromComment])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_COMMENTARIES)
        .doc(comment.keyFromComment)
        .update({
      FIRESTORE_DATABASE_COMMENTARIES_COMMENT_LIKED_BY:
          FieldValue.arrayRemove([getLoggedUserId()])
    });
  }

  Future<void> sendLikeFor(CommentarieModel comment) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_COMMENTS:
          FieldValue.arrayUnion([comment.keyFromComment])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_COMMENTARIES)
        .doc(comment.keyFromComment)
        .update({
      FIRESTORE_DATABASE_COMMENTARIES_COMMENT_LIKED_BY:
          FieldValue.arrayUnion([getLoggedUserId()])
    });
  }

  Future<List<UploadsModel>> getListOfPostForFeed() async {
    List<UploadsModel> feedList = [];

    List<String> loggedAsUserFollowerOf = [];

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .get()
        .then((loggedUserData) {
      for (final user in loggedUserData
          .data()![FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWER_OF]) {
        loggedAsUserFollowerOf.add(user.toString());
      }
    });

    List<String> keysFromAllUploadsOfAllFollowerOf = [];
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .get()
        .then((allDatabaseUsers) {
      for (final user in allDatabaseUsers.docs) {
        for (final followerOfKey in loggedAsUserFollowerOf) {
          if (followerOfKey ==
              user.data()[FIRESTORE_DATABASE_USERS_DOCUMENT_KEY]) {
            for (final uploadKey in user
                .data()[FIRESTORE_DATABASE_USERS_DOCUMENT_USER_UPLOADS]) {
              keysFromAllUploadsOfAllFollowerOf.add(uploadKey.toString());
            }
          }
        }
      }
    });

    for (String uploadKey in keysFromAllUploadsOfAllFollowerOf) {
      await _firebaseFirestore
          .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
          .doc(uploadKey)
          .get()
          .then((upload) {
        UploadsModel uploadsModel = UploadsModel('', Timestamp.now(), '');
        uploadsModel.setUserModelWith(upload.data());
        feedList.add(uploadsModel);
      });
    }

    return feedList;
  }

  Future<void> deleteCommentarieFromDatabase(
      CommentarieModel commentarieModel) async {
    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_COMMENTARIES)
        .doc(commentarieModel.keyFromComment)
        .delete();

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(commentarieModel.sendedByKey)
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_COMMENTS_SENDED:
          FieldValue.arrayRemove([commentarieModel.keyFromComment])
    });

    await _firebaseFirestore
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(commentarieModel.keyFromUpload)
        .update({
      FIRESTORE_DATABASE_UPLOADS_COMMENT_KEYS:
          FieldValue.arrayRemove([commentarieModel.keyFromComment])
    });
    //TODO: Verirficar a necessidade de remover o id do mesmo dos usuarios que deram LIKE
  }
}
