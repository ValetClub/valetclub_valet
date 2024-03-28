import 'package:flutter/material.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recharge',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Recharge  Screen'),
        ),
      ),
    );
  }
}
