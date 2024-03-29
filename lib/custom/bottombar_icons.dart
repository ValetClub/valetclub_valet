import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:valetclub_valet/common/theme.dart';

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
        color: MainTheme.mainColor,
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
            rippleColor: MainTheme.greyColor.withOpacity(0.5),
            hoverColor: MainTheme.greyColor.withOpacity(0.2),
            gap: 5,
            activeColor: MainTheme.mainColor,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            tabBackgroundColor: MainTheme.secondaryColor.withOpacity(0.9),
            tabs: [
              GButton(
                icon: Icons.home,
                leading: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/images/home.png',
                    color: selectedIndex == 0
                        ? MainTheme.mainColor
                        : MainTheme.secondaryColor,
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
                        ? MainTheme.mainColor
                        : MainTheme.secondaryColor,
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
                        ? MainTheme.mainColor
                        : MainTheme.secondaryColor,
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
                        ? MainTheme.mainColor
                        : MainTheme.secondaryColor,
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
                        ? MainTheme.mainColor
                        : MainTheme.secondaryColor,
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
