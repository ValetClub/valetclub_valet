import 'package:flutter/material.dart';

class PartenaireScreen extends StatelessWidget {
  const PartenaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partenaire'),
        backgroundColor: const Color(0xFFE23777),
        foregroundColor: Colors.white,
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
