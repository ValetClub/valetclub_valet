import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE23777),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 5,
            activeColor: const Color(0xFFE23777),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            tabBackgroundColor: Colors.grey[200]!,
            tabs: [
              GButton(
                icon: Icons.home,
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/images/home.png',
                    color: selectedIndex == 0
                        ? const Color(0xFFE23777)
                        : Colors.white,
                  ),
                ),
                text: "Home",
              ),
              GButton(
                icon: Icons.local_activity,
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/images/activity.png',
                    color: selectedIndex == 1
                        ? const Color(0xFFE23777)
                        : Colors.white,
                  ),
                ),
                text: "Activity",
              ),
              GButton(
                icon: Icons.scanner,
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/images/scan.png',
                    color: selectedIndex == 2
                        ? const Color(0xFFE23777)
                        : Colors.white,
                  ),
                ),
                text: "Scan",
              ),
              GButton(
                icon: Icons.notification_add_sharp,
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/images/notification.png',
                    color: selectedIndex == 3
                        ? const Color(0xFFE23777)
                        : Colors.white,
                  ),
                ),
                text: "Notification",
              ),
              GButton(
                icon: Icons.camera,
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/images/profile.png',
                    color: selectedIndex == 4
                        ? const Color(0xFFE23777)
                        : Colors.white,
                  ),
                ),
                text: "Profile",
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
