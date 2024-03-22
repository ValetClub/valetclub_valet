import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:valetclub_valet/auth/login_phone.dart';
import 'package:valetclub_valet/auth/password_screen.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/custom/suivant_button.dart';
import 'package:valetclub_valet/custom/text_field.dart';

class RegisterScreen extends StatefulWidget {
  final String phoneNumber;

  const RegisterScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late FocusNode _nomFocusNode;
  late FocusNode _prenomFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _phoneNumberFocusNode;

  @override
  void initState() {
    super.initState();
    _phoneNumberController.text = widget.phoneNumber;

    _nomFocusNode = FocusNode();
    _prenomFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nomFocusNode.dispose();
    _prenomFocusNode.dispose();
    _emailFocusNode.dispose();
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildLogo(),
                  const SizedBox(height: 5),
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
                  const SizedBox(height: 39),
                  _buildRegisterForm(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PlusTardButton(context),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SuivantButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PasswordScreen(
                                    email: _emailController.text,
                                    nom: _nomController.text,
                                    prenom: _prenomController.text,
                                    phoneNumber: widget.phoneNumber,
                                  ),
                                ),
                              );
                            }
                          },
                          buttonText: "Suivant",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildLoginOption(),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CustomTextField(
            controller: _nomController,
            labelText: "Entrez votre nom",
            focusNode: _nomFocusNode,
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter your nom";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _prenomController,
            labelText: "Entrez votre Prenom",
            focusNode: _prenomFocusNode,
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter your prenom";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            labelText: "Entrez votre adresse E-mail",
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
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
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            readOnly: true,
            style: const TextStyle(color: Colors.blue),
            decoration: InputDecoration(
              prefixText: "+212 \t",
              labelText: "Entrez votre phone number",
              prefixStyle: const TextStyle(color: Colors.blue),
              labelStyle: const TextStyle(color: Colors.blue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginOption() {
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPhone()),
              );
            },
            child: Text.rich(
              TextSpan(
                text: 'Sign in',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPhone()),
                    );
                  },
              ),
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
