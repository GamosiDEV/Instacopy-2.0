import 'package:flutter/material.dart';

class TabSearchView extends StatelessWidget {
  const TabSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Sair da Pesquisa'),
        ),
      ],
    );
  }
}
