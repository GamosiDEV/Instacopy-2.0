import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabaseController {
  bool hasLogged() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      return true;
    }
    print('not logged');
    return false;
  }

  void login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'gamosi.dev@gmail.com', password: '12345678');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(
            'No user found for that email.'); //transformar isso em um Span Text (pop-up)
      } else if (e.code == 'wrong-password') {
        print(
            'Wrong password provided for that user.'); //transformar isso em um Span Text (pop-up)
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
