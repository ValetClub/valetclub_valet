import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/custom/button.dart';

import 'package:valetclub_valet/custom/text_field.dart';
import 'package:valetclub_valet/pages/home_screen.dart';
import 'package:valetclub_valet/screens/landing_screen.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String _error = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildLogo(),
                  const SizedBox(height: 10),
                  Center(
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: MainTheme.secondaryColor,
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
                                    "Se connecter",
                                    style: TextStyle(
                                        color: MainTheme.secondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildLoginEmailForm(),
                  const SizedBox(height: 10),
                  CustomButton(
                    buttonText: "Connexion",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found' ||
                              e.code == 'wrong-password') {
                            setState(() {
                              _error = 'Invalid email or password';
                            });
                          } else {
                            setState(() {
                              _error = 'An error . Please try again.';
                            });
                          }
                        } catch (e) {
                          print(e);
                          setState(() {
                            _error = 'An unexpected error . Please try again .';
                          });
                        }
                      } else {
                        setState(() {
                          _error =
                              'Please fill in both email and password fields';
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const Center(
                      child: Text("Ou connectez-vous avec",
                          style: TextStyle(color: MainTheme.secondaryColor))),
                  _buildNumberConnexionButton(),
                  if (_error.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        _error,
                        style: const TextStyle(color: MainTheme.warningColor),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginEmailForm() {
    final FocusNode passwordFocusNode = FocusNode();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CustomTextField(
            focusNode: _emailFocusNode,
            controller: _emailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(val)) {
                return "Please enter a valid email address";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _passwordController,
            focusNode: passwordFocusNode,
            labelText: 'Password',
            isPassword: true,
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter your password";
              }
              if (val.length < 8) {
                return "Password must be at least 8 characters long";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNumberConnexionButton() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LandingScreen(),
              ),
            );
          },
          color: MainTheme.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, color: MainTheme.mainColor),
                SizedBox(width: 5),
                Text(
                  "Login with Phone Number",
                  style: TextStyle(color: MainTheme.darkColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
