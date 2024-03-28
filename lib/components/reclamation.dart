import 'package:flutter/material.dart';

class ReclamationScreen extends StatelessWidget {
  const ReclamationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reclamations',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
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
