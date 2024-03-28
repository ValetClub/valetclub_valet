import 'package:flutter/material.dart';

class ContactNousScreen extends StatelessWidget {
  const ContactNousScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactez Nous'),
        backgroundColor: const Color(0xFFE23777),
        foregroundColor: Colors.white,
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
