import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  final bool isFromBottomNavBar;
  const ActivityScreen({
    super.key,
    required this.isFromBottomNavBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Condition Of showing AppBar or Not based on
      // whether the screen is opened from BottomNavigationBar or not
      appBar: isFromBottomNavBar
          ? null
          : AppBar(
              title: const Text(
                'Activities',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Activity Screen'),
        ),
      ),
    );
  }
}
