import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/login_controller.dart';
import 'package:instacopy2/Theme/app_colors.dart';
import 'package:instacopy2/View/forgot_password_view.dart';
import 'package:instacopy2/View/home_feed_view.dart';
import 'package:instacopy2/View/register_account_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();

  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.introductionBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 8.0,
              color: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: emailTextFieldController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'E-mail',
                        hintText: 'Digite seu e-mail',
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressLoginButton,
                      child: const Text('Entrar'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      text: TextSpan(
                          text: 'Crie sua conta agora!',
                          style: const TextStyle(
                              color: AppColors.textLinkColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = onTapCreateAccountTextSpan),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      text: TextSpan(
                          text: 'Esqueceu sua senha?',
                          style: const TextStyle(
                              color: AppColors.textLinkColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = onTapForgotPasswordTextSpan),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPressLoginButton() {
    print('---');
    print(loginController.loginUserWithEmailAndPassword(
        emailTextFieldController.text, passwordTextFieldController.text));
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeFeedView()));
  }

  void onTapCreateAccountTextSpan() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ResgisterAccountView()));
  }

  void onTapForgotPasswordTextSpan() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPasswordView()));
  }
}
