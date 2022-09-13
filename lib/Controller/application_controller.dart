import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplicationController {
  static void showSnackBar(String snackBarText, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        snackBarText,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
