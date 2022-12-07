import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/users_model.dart';

class RegisterAccountController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  void createNewAccountOnFirestore(
      UsersModel newUser, BuildContext context) async {
    await _firebaseDatabaseController
        .createNewAccountInUserCollection(newUser)
        .whenComplete(() {
      onSucess(context);
    });
  }

  Future<String?> createAccountOnAuthAndReturnKeyFromNewUser(
      String email, String password) async {
    return await signUpOnFirebaseAuthenticator(email, password);
  }

  Future<String?> signUpOnFirebaseAuthenticator(
      String email, String password) async {
    String? id;
    await _firebaseDatabaseController
        .signUpWithEmailAndPassword(email, password)
        .then((value) {
      id = value;
    });
    return id;
  }

  void onSucess(BuildContext context) {
    ApplicationController.showSnackBar(
        'Conta Criada com sucesso! Agora basta confirmar seu email e realizar o login para começar a usar.',
        context);
    Navigator.pop(context);
  }
}
