import 'package:flutter/material.dart';

class CarParkingScreen extends StatelessWidget {
  const CarParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Parking'),
        backgroundColor: const Color(0xFFE23777),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Car Parking Screen'),
        ),
      ),
    );
  }
}
