import 'package:flutter/material.dart';
import 'package:valetclub_valet/components/settings.dart';
import 'package:valetclub_valet/screens/landing_screen.dart';
import 'package:valetclub_valet/services/otp.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
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
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/activity.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Mes activités'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/partner.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Partenaire'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/profile.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Profile'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/car_key.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('My Cars in parking'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/reclamation.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Reclamation'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/settings.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pushReplacement(
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
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/contact.png',
                      width: 20,
                      height: 20,
                    ),
                    title: const Text('Contactez nous'),
                    onTap: () {},
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
