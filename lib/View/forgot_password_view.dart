import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/forgot_password_controller.dart';
import 'package:instacopy2/Theme/app_colors.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

ForgotPasswordController _forgotPasswordController = ForgotPasswordController();

TextEditingController emailTextFieldController = TextEditingController();

String? emailTextFieldErrorHint;

bool asSendButtonDisble = false;

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.introductionBackgroundColor,
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
                    padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 6.0),
                    child: Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Digite o e-mail correspondente de sua conta no campo abaixo e nós lhe enviaremos uma mensagem para redefinir sua senha!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.secondaryFontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: emailTextFieldController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'E-mail',
                        hintText: 'Digite o e-mail de sua conta',
                        errorText: emailTextFieldErrorHint,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: sendPasswordRecoveryMessage,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Enviar para recuperação',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
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

  void sendPasswordRecoveryMessage() async {
    changeAsSendButtonDisbleState(true);
    clearErrorHints();
    if (asEmailValid()) {
      await _forgotPasswordController
          .sendForgotPasswordMessageByEmail(emailTextFieldController.text)
          .then((value) {
        changeAsSendButtonDisbleState(false);
        noticeUserAndPopScreen();
      });
    }
  }

  void noticeUserAndPopScreen() {
    ApplicationController.showSnackBar(
        'Caso exista uma conta com este e-mail uma mensagem de redefinição de senha sera enviada, portanto basta aguardar',
        context);
    Navigator.of(context).pop();
  }

  void clearErrorHints() {
    emailTextFieldErrorHint = null;
  }

  bool asEmailValid() {
    bool asValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailTextFieldController.text);
    if (asValidEmail && emailTextFieldController.text != '') {
      return asValidEmail;
    }
    setErrorHint();
    return asValidEmail;
  }

  void changeAsSendButtonDisbleState(bool state) {
    asSendButtonDisble = state;
  }

  void setErrorHint() {
    setState(() {
      emailTextFieldErrorHint = 'E-mail digitado é invalido!';
    });
  }
}
