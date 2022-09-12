import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Controller/register_account_controller.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/Theme/app_colors.dart';

class ResgisterAccountView extends StatefulWidget {
  const ResgisterAccountView({Key? key}) : super(key: key);

  @override
  State<ResgisterAccountView> createState() => _ResgisterAccountViewState();
}

class _ResgisterAccountViewState extends State<ResgisterAccountView> {
  final RegisterAccountController _registerAccountController =
      RegisterAccountController();
  TextEditingController emailTextFieldController = TextEditingController();
  TextEditingController fullnameTextFieldController = TextEditingController();
  TextEditingController usernameTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();

  String? emailTextFieldErrorHint;
  String? passwordTextFieldErrorHint;
  String? fullnameTextFieldErrorHint;
  String? usernameTextFieldErrorHint;

  static const String INVALID_EMAIL = 'INVALID_EMAIL';
  static const String INVALID_FULLNAME = 'INVALID_FULLNAME';
  static const String INVALID_USERNAME = 'INVALID_USERNAME';
  static const String INVALID_PASSWORD = 'INVALID_PASSWORD';

  UsersModel? newUserModel = null;

  bool asSignUpButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10.0,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Instacopy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Cadastre-se para ver fotos de seus amigos.',
                      style: TextStyle(
                        color: AppColors.secondaryFontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 1.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: emailTextFieldController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'E-mail',
                        hintText: 'Digite seu e-mail',
                        errorText: emailTextFieldErrorHint,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: fullnameTextFieldController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Nome completo',
                        hintText: 'Digite seu nome completo',
                        errorText: fullnameTextFieldErrorHint,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: usernameTextFieldController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Nome de usuario',
                        hintText: 'Digite seu nome de usuario',
                        errorText: usernameTextFieldErrorHint,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: passwordTextFieldController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        errorText: passwordTextFieldErrorHint,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
                    child: ElevatedButton(
                      onPressed: asSignUpButtonEnabled ? null : onPressSignUp,
                      child: const Text(
                        'Cadastrar-se',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool asDataInTextField(TextEditingController textFieldController) {
    if (textFieldController.text != null && textFieldController.text != '') {
      return true;
    }
    return false;
  }

  bool checkIfAllTextFieldsAreFilledAndValid() {
    clearErrorHints();
    bool asValid = true;
    if (!asDataInTextField(emailTextFieldController)) {
      setErrorHint(INVALID_EMAIL);
      asValid = false;
    } else {
      asValid = asEmailValid(emailTextFieldController.text);
    }
    if (!asDataInTextField(fullnameTextFieldController)) {
      setErrorHint(INVALID_FULLNAME);
      asValid = false;
    }
    if (!asDataInTextField(usernameTextFieldController)) {
      setErrorHint(INVALID_USERNAME);
      asValid = false;
    }
    if (!asDataInTextField(passwordTextFieldController)) {
      setErrorHint(INVALID_PASSWORD);
      asValid = false;
    }
    return asValid;
  }

  bool asEmailValid(String email) {
    bool asValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (asValidEmail) {
      return asValidEmail;
    }
    setErrorHint(INVALID_EMAIL);
    return asValidEmail;
  }

  void setErrorHint(String field) {
    setState(() {
      if (field == INVALID_EMAIL) {
        emailTextFieldErrorHint = 'E-mail digitado invalido!';
      }
      if (field == INVALID_PASSWORD) {
        passwordTextFieldErrorHint = 'Senha digitada invalida!';
      }
      if (field == INVALID_FULLNAME) {
        fullnameTextFieldErrorHint = 'Nome digitado invalido!';
      }
      if (field == INVALID_USERNAME) {
        usernameTextFieldErrorHint = 'Nome de usuario invalido!';
      }
    });
  }

  void clearErrorHints() {
    setState(() {
      emailTextFieldErrorHint = null;
      fullnameTextFieldErrorHint = null;
      usernameTextFieldErrorHint = null;
      passwordTextFieldErrorHint = null;
    });
  }

  void onPressSignUp() {
    if (checkIfAllTextFieldsAreFilledAndValid()) {
      progressWithAccountCreation();
    }
  }

  void progressWithAccountCreation() async {
    chageSignUpButtonState();
    await createAccountOnAuthAndSetDataOnNewUserModel().then((value) {
      if (isNewUserModelWithData()) {
        _registerAccountController.createNewAccountOnFirestore(
            newUserModel!, context);
        chageSignUpButtonState();
      }
    });
  }

  void chageSignUpButtonState() {
    setState(() {
      if (asSignUpButtonEnabled) {
        asSignUpButtonEnabled = false;
      } else {
        asSignUpButtonEnabled = true;
      }
    });
  }

  Future<void> createAccountOnAuthAndSetDataOnNewUserModel() async {
    try {
      await _registerAccountController
          .createAccountOnAuthAndReturnKeyFromNewUser(
              emailTextFieldController.text, passwordTextFieldController.text)
          .then((value) {
        if (value != null) {
          newUserModel = UsersModel(
              keyFromUser: value,
              email: emailTextFieldController.text,
              fullname: fullnameTextFieldController.text,
              username: usernameTextFieldController.text);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code ==
          FirebaseDatabaseController.FIREBASE_AUTH_EMAIL_ALREADY_IN_USE_ERROR) {
        showSnackBar(
            'Este e-mail ja pertence a uma conta, por favor tente novamente com outro e-mail');
      }
    }
  }

  void showSnackBar(String snackBarText) {
    final snackBar = SnackBar(
      content: Text(
        snackBarText,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isNewUserModelWithData() {
    if (newUserModel != null) {
      return true;
    }
    return false;
  }
}
