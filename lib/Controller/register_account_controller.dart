import 'package:flutter/cupertino.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/users_model.dart';

class RegisterAccountController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  void createNewAccount(BuildContext context, String email, String fullname,
      String username, String password) async {
    String resultado = await signUpOnFirebaseAuthenticator(email, password);
    UsersModel usersModel = UsersModel(
        keyFromUser: resultado,
        email: email,
        username: username,
        fullname: fullname);

    if (usersModel.keyFromUser != null && usersModel.keyFromUser != '000') {
      await _firebaseDatabaseController
          .createNewAccountInUserCollection(usersModel)
          .then((value) => print(
              'sucesso')) //volta a tela e verifica se existe usuario logado
          .catchError(onError);
    }
  }

  void onError(dynamic e) {
    print('Erro aqui');
  }

  Future<String> signUpOnFirebaseAuthenticator(
      String email, String password) async {
    String id = '000';
    await _firebaseDatabaseController
        .signUpWithEmailAndPassword(email, password)
        .then((value) {
      if (value != null) {
        id = value;
      }
    });
    return id;
  }
}
