// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  bool hasLogged() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

  String? getLoggedUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCredential = value.user?.uid;
    });
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    return userCredential;
  }

  Future<void> createNewAccountInUserCollection(UsersModel usersModel) async {
    await FirebaseFirestore.instance
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(usersModel.keyFromUser)
        .set(usersModel.getMapFromThisModel())
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<void> signOutFromLoggedUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendForgotPasswordMessage(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> sendFeedbakcToDatabase(Map<String, String> feedback) async {
    await FirebaseFirestore.instance
        .collection(FIRESTORE_DATABASE_COLLECTION_FEEDBACKS)
        .doc()
        .set(feedback);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileUserData(
      String userId) async {
    return await FirebaseFirestore.instance
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(userId)
        .get();
  }

  Future<String> getProfileImageUrlFrom(String imageReference) async {
    if (imageReference != null && imageReference != "") {
      return await FirebaseStorage.instance
          .ref(imageReference)
          .getDownloadURL();
    }
    return '';
  }

  Future<String> sendImageToStorageAndGetReference(
      File selectedFile, UploadsModel upload) async {
    String newImageReference = FIREBASE_STORAGE_USERS +
        upload.uploaderKey +
        FIREBASE_STORAGE_USERS_UPLOADS +
        upload.keyFromUpload;

    await FirebaseStorage.instance
        .ref()
        .child(newImageReference)
        .putFile(selectedFile);

    return newImageReference;
  }

  void setIdToUploadAndSendToDatabase(
      UploadsModel upload, File selectedFile) async {
    final instance = FirebaseFirestore.instance
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
      await FirebaseFirestore.instance
          .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
          .get()
          .then((allUploads) async {
        for (final uploadDataFromDatabase in allUploads.docs) {
          if (uploadKey == uploadDataFromDatabase.id) {
            UploadsModel upload = UploadsModel('', Timestamp.now(), '');
            upload.setUserModelWith(uploadDataFromDatabase.data());
            await getDownloadUrlFrom(upload.uploadStorageReference)
                .then((downloadUrl) {
              upload.downloadedImageURL = downloadUrl.toString();
            });
            listOfUploads.add(upload);
          }
        }
      });
    }

    return listOfUploads;
  }

  Future<String> getDownloadUrlFrom(String storageReference) async {
    return await FirebaseStorage.instance
        .ref()
        .child(storageReference)
        .getDownloadURL();
  }

  void addIdOfUploadToUser(String keyFromUpload, String uploaderKey) async {
    await FirebaseFirestore.instance
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

    if (profileImageReference != getStandardProfileImageReference()) {
      profileImageReference = FIREBASE_STORAGE_USERS +
          getLoggedUserId().toString() +
          FIREBASE_STORAGE_USERS_PROFILE +
          'profile_image';

      setNewProfileImageReferenceToUser(profileImageReference);
    }

    await FirebaseStorage.instance
        .ref()
        .child(profileImageReference)
        .putFile(newImage);
  }

  String getStandardProfileImageReference() {
    return FIREBASE_STORAGE_USERS +
        getLoggedUserId().toString() +
        FIREBASE_STORAGE_USERS_PROFILE +
        'profile_image';
  }

  Future<void> setNewProfileImageReferenceToUser(
      String profileImageReference) async {
    await FirebaseFirestore.instance
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(getLoggedUserId())
        .update({
      FIRESTORE_DATABASE_USERS_DOCUMENT_PROFILE_IMAGE_REFERENCE:
          profileImageReference
    });
  }

  Future<void> updadeProfileData(UsersModel updadeUser) async {
    await FirebaseFirestore.instance
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(updadeUser.keyFromUser)
        .update(updadeUser.getMapForUpdadeProfile());
  }

  Future<String> getImageUrlBy(String reference) async {
    return await FirebaseStorage.instance.ref(reference).getDownloadURL();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUploadDataWith(
      String uploadId) async {
    return await FirebaseFirestore.instance
        .collection(FIRESTORE_DATABASE_COLLECTION_UPLOADS)
        .doc(uploadId)
        .get();
  }
}
