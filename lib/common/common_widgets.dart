import 'package:flutter/material.dart';
import 'package:valetclub_valet/pages/home_screen.dart';

// main app logo

Widget buildLogo() {
  return Center(
    child: Image.asset(
      "assets/images/logo_valet.png",
      fit: BoxFit.fitWidth,
      height: 150,
      width: 150,
    ),
  );
}

// skip button to the home screen

Widget PlusTardButton(BuildContext context) {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          "Plus Tard",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
