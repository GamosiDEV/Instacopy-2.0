import 'package:flutter/material.dart';
import 'package:instacopy2/Controller/register_account_controller.dart';
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
                      controller: fullnameTextFieldController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Nome completo',
                        hintText: 'Digite seu nome completo',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: usernameTextFieldController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Nome de usuario',
                        hintText: 'Digite seu nome de usuario',
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
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
                    child: ElevatedButton(
                      onPressed: onPressSignUp,
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

  void onPressSignUp() {
    _registerAccountController.signUpNewAccount(
        context,
        emailTextFieldController.text,
        fullnameTextFieldController.text,
        usernameTextFieldController.text,
        passwordTextFieldController.text);
  }
}
