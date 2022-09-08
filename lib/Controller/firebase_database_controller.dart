// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class FirebaseDatabaseController {
  static String FIREBASE_EMAIL_NOT_FOUND = 'user-not-found';
  static String FIREBASE_WRONG_PASSWORD = 'wrong-password';
  static String FIREBASE_SUCCESSFUL_LOGIN = 'successful-login';

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
      //metodo esta retornando antes de pegar o resultado
      String email,
      String password) async {
    String? userCredential = null;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCredential = value.user?.uid;
    });
    return userCredential;
  }

  Future<void> createNewAccountInUserCollection(UsersModel usersModel) async {
    await FirebaseFirestore.instance
        .collection(FIRESTORE_DATABASE_COLLECTION_USERS)
        .doc(usersModel.keyFromUser)
        .set(usersModel.getMapFromThisModel())
        .onError((e, _) => print("Error writing document: $e"));
  }

  void signOutFromLoggedUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
