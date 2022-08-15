import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection("cities").doc("Sab").set({
                  "name": "Santo Antonio",
                  "state": "GO",
                  "country": "BRA"
                }).whenComplete(() {
                  print('Completed');
                });
              },
              child: const Text('Firebase'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Click 2'),
            ),
            const Text(
              'Primario',
            )
          ],
        ),
      ),
    );
  }
}
