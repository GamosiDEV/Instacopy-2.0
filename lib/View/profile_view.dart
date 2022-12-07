import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/View/login_view.dart';
import 'package:instacopy2/View/tab_profile_view.dart';

class ProfileView extends StatefulWidget {
  String profileUserId;

  ProfileView({Key? key, required this.profileUserId}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabProfileView(
            profileUserId: widget.profileUserId,
            loggedUserId: ApplicationController().getLoggedUserId()));
  }
}
