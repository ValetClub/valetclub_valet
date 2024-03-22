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

//  icons in bottom of the screen

Widget bottomBar(BuildContext context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        color: Color(0xFFE23777),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Image.asset(
                'assets/images/home.png',
                width: 35,
                height: 35,
                color: Colors.white,
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ActivityScreen()),
                // );
              },
              child: Image.asset(
                'assets/images/activity.png',
                width: 35,
                height: 35,
                color: Colors.white,
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ScanScreen()),
                // );
              },
              child: Image.asset(
                'assets/images/scan.png',
                width: 35,
                height: 35,
                color: Colors.white,
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const CameraScreen()),
                // );
              },
              child: Image.asset(
                'assets/images/camera.png',
                width: 35,
                height: 35,
                color: Colors.white,
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const NotificationScreen()),
                // );
              },
              child: Image.asset(
                'assets/images/notification.png',
                width: 35,
                height: 35,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
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
