import 'package:instacopy2/Theme/app_theme.dart';
import 'package:instacopy2/View/IntroductionView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme(context).defaultTheme,
      home: IntroductionView(),
    );
  }
}
