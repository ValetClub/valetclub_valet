import 'package:flutter/material.dart';

class ReclamationScreen extends StatelessWidget {
  const ReclamationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reclamation'),
        backgroundColor: const Color(0xFFE23777),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Reclamation  Screen'),
        ),
      ),
    );
  }
}
