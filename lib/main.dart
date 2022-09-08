import 'package:instacopy2/Model/users_model.dart';
import 'package:instacopy2/Theme/app_theme.dart';
import 'package:instacopy2/View/introduction_view.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme(context).defaultTheme,
      home: const IntroductionView(),
    );
  }
}
