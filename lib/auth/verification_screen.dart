import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valetclub_valet/auth/register_screen.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/custom/text_label.dart';
import 'package:valetclub_valet/pages/home_screen.dart';
import 'package:valetclub_valet/services/otp.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const VerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  late Timer _timer;
  int _start = 30;
  String verificationId = "";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void restartTimer() {
    setState(() {
      _start = 30;
    });
    _timer.cancel();
    startTimer();
    _sendOTP();
  }

  void verifyOTP() {
    String enteredOTP = _otpController.text;
    Otp.loginWithOtp(otp: enteredOTP).then((result) {
      if (result == "Success") {
        // OTP verification successful
        // Check if the phone number exists in both Firestore and Firebase Auth
        String phoneNumberCheck = "+212${widget.phoneNumber}";

        Future.wait([
          Otp.checkPhoneNumberExists(phoneNumberCheck),
          Otp.isLoggedIn(),
        ]).then((results) {
          bool existsInFirestore = results[0];
          bool isLoggedIn = results[1];

          if (existsInFirestore && isLoggedIn) {
            // Phone number exists in both Firestore and Firebase Auth, navigate to HomeScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            // Phone number doesn't exist in both Firestore and Firebase Auth, navigate to RegisterScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(
                  phoneNumber: widget.phoneNumber,
                ),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP. Please try again.'),
            backgroundColor: MainTheme.errorColor,
          ),
        );
      }
    });
  }

  void resendOTP() {
    Otp.sentOtp(
      phone: widget.phoneNumber,
      errorStep: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error sending OTP'),
            backgroundColor: MainTheme.errorColor,
          ),
        );
      },
      nextStep: () {
        restartTimer();
      },
    );
  }

  void _sendOTP() {
    Otp.sentOtp(
      phone: widget.phoneNumber,
      errorStep: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending OTP: $error'),
            backgroundColor: MainTheme.errorColor,
          ),
        );
      },
      nextStep: () {
        setState(() {
          verificationId = Otp.verifyId;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: MainTheme.secondaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildLogo(),
                  const SizedBox(height: 16),
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
                                horizontal: 0.2,
                                vertical: 5.0,
                              ),
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
                  const SizedBox(height: 69),
                  const CustomTextLabel(
                    text: "Verifiez votre téléphone",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 6),
                  _buildModifyNumber(),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: MainTheme.thirdColor),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: InputDecoration(
                            labelText: "Enter le code",
                            labelStyle:
                                const TextStyle(color: MainTheme.thirdColor),
                            border: const OutlineInputBorder(),
                            suffixText: '00:$_start ',
                            suffixStyle:
                                const TextStyle(color: MainTheme.thirdColor),
                            filled: true,
                            fillColor: MainTheme.secondaryColor,
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter the OTP";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.length == 6) {
                              verifyOTP();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),
                  _buildClickableTextWithLine("Renvoyez le code", resendOTP),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModifyNumber() {
    return RichText(
      text: TextSpan(
        text:
            'Vous allez recevoir un SMS avec un code de verification \n sur +212${widget.phoneNumber}',
        style: const TextStyle(color: MainTheme.secondaryColor),
        children: const [
          TextSpan(
            text: '\tModifiez votre numéro',
            style: TextStyle(
                color: MainTheme.thirdColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableTextWithLine(String text, void Function()? onTap) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 1,
              width: 50,
              color: MainTheme.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
