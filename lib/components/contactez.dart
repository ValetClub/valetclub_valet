import 'package:flutter/material.dart';

class ContactNousScreen extends StatelessWidget {
  const ContactNousScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contactez Nous',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Contactez Nous  Screen'),
        ),
      ),
    );
  }
}
