import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/feedback_send_controller.dart';
import 'package:instacopy2/Theme/app_colors.dart';
import 'package:instacopy2/View/login_view.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class FeedbackSendView extends StatefulWidget {
  const FeedbackSendView({Key? key}) : super(key: key);

  @override
  State<FeedbackSendView> createState() => _FeedbackSendViewState();
}

FeedbackSendController _feedbackSendController = FeedbackSendController();

TextEditingController emailTextFieldController = TextEditingController();
TextEditingController feedbackTextFieldController = TextEditingController();

class _FeedbackSendViewState extends State<FeedbackSendView> {
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
                      'Escreva seu Feedback abaixo!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: emailTextFieldController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Anexe um e-mail ao Feedback',
                        hintText: 'E-mail',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: feedbackTextFieldController,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        alignLabelWithHint: true,
                        labelText: 'Escreva aqui seu Feedback',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: sendFeedbackToDatabase,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Enviar feedback',
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

  void sendFeedbackToDatabase() {
    _feedbackSendController
        .sendFeedbackToDatabase(turnFeedbackDataIntoMap())
        .then((value) {
      returnScreenAndNoticeUser();
    });
  }

  Map<String, dynamic> turnFeedbackDataIntoMap() {
    return {
      FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_EMAIL: emailTextFieldController.text,
      FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_FEEDBACK_TEXT:
          feedbackTextFieldController.text,
      FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_DATE: Timestamp.now(),
      FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_ASREAD: false,
    };
  }

  void returnScreenAndNoticeUser() {
    Navigator.pop(context);
    ApplicationController.showSnackBar(
        'Feedback enviado a base de dados, Obrigado por enviar!', context);
  }
}
