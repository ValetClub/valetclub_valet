import 'package:flutter/material.dart';
import 'package:valetclub_valet/auth/login_email.dart';
import 'package:valetclub_valet/auth/login_phone.dart';
import 'package:valetclub_valet/auth/register_screen.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/custom/text_label.dart';
import 'package:valetclub_valet/pages/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 90),
              child: Column(
                children: <Widget>[
                  buildLogo(),
                  const SizedBox(height: 20),
                  const CustomTextLabel(
                    text: 'Easy way to Connect with the\nuser',
                  ),
                  const SizedBox(height: 20),
                  _buildPhoneNumberForm(context),
                  const SizedBox(height: 20),
                  _buildHomeScreenButton(context),
                  _buildRegisterScreenButton(context),
                  const SizedBox(height: 100),
                  _buildLoginOption(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberForm(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPhone()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Colors.white),
          color: Colors.white,
        ),
        child: TextFormField(
          enabled: false,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.phone, color: Colors.pink),
            labelText: "Continuez avec votre numéro de téléphone",
            labelStyle: TextStyle(color: Colors.blue),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginOption(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginEmail()));
            },
            child: const Text.rich(
              TextSpan(
                text: 'Sign in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreenButton(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        color: const Color(0xFFE23777),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        child: const Text(
          "Home screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRegisterScreenButton(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterScreen(
                        phoneNumber: '',
                      )));
        },
        color: const Color(0xFFE23777),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
