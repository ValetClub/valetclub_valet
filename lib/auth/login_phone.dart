import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:valetclub_valet/auth/verification_screen.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/custom/button.dart';
import 'package:valetclub_valet/custom/text_field.dart';
import 'package:valetclub_valet/custom/text_label.dart';

import 'package:valetclub_valet/screens/termes_conditions.dart';
import 'package:valetclub_valet/services/otp.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({
    super.key,
  });

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool _isSendingOTP = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
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
                                  color: Colors.white,
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
                  const SizedBox(height: 20),
                  const CustomTextLabel(
                    text: 'Entrez votre numéro de\ntéléphone',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  _buildLoginPhoneForm(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? newVal) {
                          setState(() {
                            isChecked = newVal!;
                          });
                        },
                      ),
                      _termesConditionsOption(),
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    buttonText: "Suivant",
                    onPressed: () async {
                      await _sendOTP();
                    },
                    isLoading: _isSendingOTP,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPhoneForm() {
    return Form(
      key: _formKey,
      child: CustomTextField(
        focusNode: _phoneNumberFocusNode,
        controller: _phoneNumberController,
        labelText: 'Enter your phone number',
        prefixText: '+212 \t',
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(9),
        ],
        validator: (val) {
          if (val!.isEmpty) {
            return "Please enter your phone number";
          }
          if (val.length != 9) {
            return "Phone number must contain exactly 9 digits";
          }
          return null;
        },
      ),
    );
  }

  Widget _termesConditionsOption() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TermesConditions(),
          ),
        );
      },
      child: RichText(
        text: const TextSpan(
          text: 'En créant un compte, vous acceptez nos\n',
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: 'Termes et conditions',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate() && isChecked && !_isSendingOTP) {
      final phoneNumber = _phoneNumberController.text;
      setState(() {
        _isSendingOTP = true;
      });
      await _sendOtpAndNavigate(phoneNumber);
      setState(() {
        _isSendingOTP = false;
      });
    }
  }

  Future<void> _sendOtpAndNavigate(String phoneNumber) async {
    await Otp.sentOtp(
      phone: phoneNumber,
      errorStep: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send OTP'),
            backgroundColor: Colors.red,
          ),
        );
      },
      nextStep: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              phoneNumber: phoneNumber,
            ),
          ),
        );
      },
    );
  }
}
