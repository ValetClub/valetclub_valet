import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/theme.dart';

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
        backgroundColor: MainTheme.secondaryColor,
        foregroundColor: MainTheme.darkColor,
      ),
      body: Container(
        color: MainTheme.secondaryColor,
        child: const Center(
          child: Text('Contactez Nous  Screen'),
        ),
      ),
    );
  }
}
