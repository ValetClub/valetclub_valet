import 'package:flutter/material.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recharge'),
        backgroundColor: const Color(0xFFE23777),
        foregroundColor: Colors.white,
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
