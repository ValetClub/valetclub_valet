import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/theme.dart';
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
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String userId = user?.uid ?? '';
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: double.infinity,
      color: MainTheme.secondaryColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: MainTheme.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: [
                  //Making the circle around the Image
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFEC7BA5),
                        width: 4,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/logo_valet.png'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (!snapshot.hasData || snapshot.data!.data() == null) {
                        return const Text('User not found');
                      }

                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final nom = userData['nom'] as String;
                      final prenom = userData['prenom'] as String;
                      final fullname = '$nom $prenom';
                      return Text(
                        fullname,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: MainTheme.secondaryColor,
                        ),
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Id :',
                        style: TextStyle(
                          fontSize: 8,
                          color: MainTheme.secondaryColor,
                        ),
                      ),
                      Text(
                        userId,
                        style: const TextStyle(
                          fontSize: 8,
                          color: MainTheme.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: MainTheme.secondaryColor,
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
                  const SizedBox(height: 10),
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
                                color: MainTheme.mainColor,
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
