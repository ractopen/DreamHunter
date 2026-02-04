import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gameplay running'),
      ),
      body: const Center(
        child: Text('You are on Gameplay space'),
      ),
    );
  }
}
