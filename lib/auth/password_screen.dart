import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/custom/button.dart';
import 'package:valetclub_valet/custom/text_field.dart';
import 'package:valetclub_valet/valet%20informations/first_screen.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  final String nom;
  final String prenom;
  final String phoneNumber;

  const PasswordScreen({
    Key? key,
    required this.email,
    required this.nom,
    required this.prenom,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildLogo(),
                  const SizedBox(height: 6),
                  Center(
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.2, vertical: 5.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Registration",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  _buildPasswordForm(),
                  const SizedBox(height: 16),
                  CustomButton(
                    buttonText: "Connexion",
                    onPressed: _registerUser,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordForm() {
    final FocusNode passwordFocusNode = FocusNode();
    final FocusNode confirmPasswordFocusNode = FocusNode();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            focusNode: passwordFocusNode,
            labelText: "Mot de passe",
            isPassword: true,
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter a password";
              }
              if (val.length < 8) {
                return "Password must be at least 8 characters long";
              }
              return null;
            },
          ),
          const SizedBox(height: 26),
          CustomTextField(
            focusNode: confirmPasswordFocusNode,
            controller: _confirmPasswordController,
            labelText: "Confirmez le mot de passe",
            isPassword: true,
            validator: (val) {
              if (val!.isEmpty) {
                return "Please confirm your password";
              }
              if (val != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Future<void> _registerUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Create user with email and password
        final userCredential = EmailAuthProvider.credential(
            email: widget.email, password: _passwordController.text);
        // Store user information in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .set({
          'nom': widget.nom,
          'prenom': widget.prenom,
          'phoneNumber': "+212${widget.phoneNumber}",
          'role': "valet",
          'email': widget.email,
        });

        // Link email/password with phone number
        await currentUser.linkWithCredential(userCredential);

        // Navigate to next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoFirstScreen(),
          ),
        );
      } catch (e) {
        print('Error: $e');

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
