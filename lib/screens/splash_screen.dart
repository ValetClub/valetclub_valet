import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/pages/home_screen.dart';
import 'package:valetclub_valet/screens/landing_screen.dart';
import 'package:valetclub_valet/services/otp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const CheckUserLoggedInOrNot(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildLogo(),
                const SizedBox(height: 10),
                const Text(
                  'Valet Club',
                  style: TextStyle(
                    fontSize: 15,
                    color: MainTheme.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'For Drivers',
                  style: TextStyle(
                    fontSize: 10,
                    color: MainTheme.secondaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 50),
                const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MainTheme.secondaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckUserLoggedInOrNot extends StatefulWidget {
  const CheckUserLoggedInOrNot({
    super.key,
  });

  @override
  State<CheckUserLoggedInOrNot> createState() => _CheckUserLoggedInOrNotState();
}

class _CheckUserLoggedInOrNotState extends State<CheckUserLoggedInOrNot> {
  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  Future<void> _checkUserLoggedIn() async {
    final isLoggedIn = await Otp.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
