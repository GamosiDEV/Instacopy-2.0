import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/View/login_view.dart';

class TabFeedView extends StatelessWidget {
  const TabFeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            FirebaseDatabaseController().signOutFromLoggedUser();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginView()));
          },
          child: const Text('Sair da Home'),
        ),
      ],
    );
  }
}
