import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/View/login_view.dart';
import 'package:instacopy2/View/upload_image_view.dart';

class ApplicationController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  static void showSnackBar(String snackBarText, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        snackBarText,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void logout(BuildContext context) {
    _firebaseDatabaseController.signOutFromLoggedUser().then((_) {
      returnToLoginScreen(context);
    });
  }

  void returnToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
  }

  Future<void> toUploadImageView(BuildContext context, userId) async {
    bool? hasUploaded = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadImageView(loggedUserId: userId)));

    if (hasUploaded != null && hasUploaded) {
      showSnackBar('Sua imagem esta sendo enviada!', context);
    }
  }

  Widget setProfileImageFrom(String url) {
    return url == ''
        ? Image.asset('assets/images/profile.jpg')
        : Image.network(url);
  }

  String? getLoggedUserId() {
    return _firebaseDatabaseController.getLoggedUserId();
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: file.lengthSync() < 600000 ? 50 : 25,
    );
    return compressedFile;
  }
}
