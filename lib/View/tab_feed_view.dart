import 'package:flutter/material.dart';

class TabFeedView extends StatelessWidget {
  const TabFeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Sair da Home'),
        ),
      ],
    );
  }
}
