import 'package:flutter/material.dart';

class PartenaireScreen extends StatelessWidget {
  const PartenaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Partenaire',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Partenaire  Screen'),
        ),
      ),
    );
  }
}
