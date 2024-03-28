import 'package:flutter/material.dart';
import 'package:valetclub_valet/components/cars_parking.dart';
import 'package:valetclub_valet/components/contactez.dart';
import 'package:valetclub_valet/components/faq.dart';
import 'package:valetclub_valet/components/partenaire.dart';
import 'package:valetclub_valet/components/recharge.dart';
import 'package:valetclub_valet/components/reclamation.dart';
import 'package:valetclub_valet/components/settings.dart';
import 'package:valetclub_valet/pages/activity_screen.dart';
import 'package:valetclub_valet/pages/profile_screen.dart';
import 'package:valetclub_valet/screens/landing_screen.dart';
import 'package:valetclub_valet/services/otp.dart';

class Sidebar extends StatelessWidget {
  final bool isFromBottomNavBar;
  const Sidebar({
    required this.isFromBottomNavBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE23777),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: const Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo_valet.png'),
                    radius: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'test valet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ID: 12345',
                    style: TextStyle(
                      fontSize: 6,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/images/wallet.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Recharge Portefeuille client'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RechargeScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/activity.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Mes activités'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityScreen(
                              isFromBottomNavBar: isFromBottomNavBar),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/partner.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Partenaire'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PartenaireScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/profile.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                              isFromBottomNavBar: isFromBottomNavBar),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/car_key.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('My Cars in parking'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarParkingScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/reclamation.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Reclamation'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReclamationScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/settings.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/faq.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('FAQ'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FaqScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/contact.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Contactez nous'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactNousScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 32),
                      child: GestureDetector(
                        onTap: () {
                          Otp.logout().then(
                            (val) {
                              print("Signed Out");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LandingScreen(),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/exit.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Logout',
                              style: TextStyle(
                                color: Color(0xFFE23777),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
