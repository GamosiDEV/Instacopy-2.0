import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabaseController {
  static String FIREBASE_USER_NOT_FOUND = 'user-not-found';
  static String FIREBASE_WRONG_PASSWORD = 'wrong-password';
  static String FIREBASE_SUCCESSFUL_LOGIN = 'successful-login';

  bool hasLogged() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      return true;
    }
    print('not logged');
    return false;
  }

  Future<String> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return FIREBASE_USER_NOT_FOUND; //transformar isso em um pop-up
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return FIREBASE_WRONG_PASSWORD; //transformar isso em um pop-up
      }
    }
    return FIREBASE_SUCCESSFUL_LOGIN;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
