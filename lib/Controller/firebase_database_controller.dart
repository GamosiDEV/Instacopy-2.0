import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabaseController {
  static String FIREBASE_EMAIL_NOT_FOUND = 'user-not-found';
  static String FIREBASE_WRONG_PASSWORD = 'wrong-password';
  static String FIREBASE_SUCCESSFUL_LOGIN = 'successful-login';

  bool hasLogged() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      return true;
    }
    return false;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return FIREBASE_SUCCESSFUL_LOGIN;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return FIREBASE_WRONG_PASSWORD;
      } else {
        return FIREBASE_EMAIL_NOT_FOUND;
      }
    }
  }

  void signOutFromLoggedUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
