import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/theme.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: MainTheme.secondaryColor,
        foregroundColor: MainTheme.darkColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: MainTheme.secondaryColor,
        child: const Center(
          child: Text('FAQ  Screen'),
        ),
      ),
    );
  }
}
