import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/custom/suivant_button.dart';
import 'package:valetclub_valet/pages/home_screen.dart';

class CustomTextEditingController extends TextEditingController {
  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class InfoSecondScreen extends StatefulWidget {
  const InfoSecondScreen({
    super.key,
  });

  @override
  _InfoSecondScreenState createState() => _InfoSecondScreenState();
}

class _InfoSecondScreenState extends State<InfoSecondScreen> {
  late CustomTextEditingController _dateController;
  late TextEditingController _nationalityController;
  late TextEditingController _driverLicenseController;
  final _formKey = GlobalKey<FormState>();
  late XFile? _pickedImage;
  late String _pickedImageName;
  late String _imagePath;

  late FocusNode _nationalityFocusNode;
  late FocusNode _driverLicenseFocusNode;
  late FocusNode _dateFocusNode;

  @override
  void initState() {
    super.initState();
    _dateController = CustomTextEditingController();
    _dateController.text = '01/01';
    _nationalityController = TextEditingController();
    _driverLicenseController = TextEditingController();
    _nationalityFocusNode = FocusNode();
    _driverLicenseFocusNode = FocusNode();
    _dateFocusNode = FocusNode();
    _pickedImageName = '';
    _imagePath = '';
  }

  @override
  void dispose() {
    _nationalityFocusNode.dispose();
    _driverLicenseFocusNode.dispose();
    _dateFocusNode.dispose();
    _nationalityController.dispose();
    _driverLicenseController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
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
                                "Complete agent Profile",
                                style:
                                    TextStyle(color: MainTheme.secondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: _nationalityController,
                focusNode: _nationalityFocusNode,
                labelText: 'Nationality',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _driverLicenseController,
                focusNode: _driverLicenseFocusNode,
                labelText: 'Driver\'s License',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: _buildDateInput(),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 4,
                    child: _buildImageInput(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: PlusTardButton(context),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SuivantButton(
                      onPressed: _validateInputs,
                      buttonText: "Suivant",
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: const TextStyle(color: MainTheme.thirdColor),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: MainTheme.thirdColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        filled: true,
        fillColor: MainTheme.secondaryColor,
        suffixIcon: _buildClearIconButton(controller, focusNode),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildClearIconButton(
      TextEditingController controller, FocusNode focusNode) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final hasText = value.text.isNotEmpty;
        return IconButton(
          onPressed: hasText
              ? () {
                  setState(() {
                    controller.clear();
                  });
                }
              : null,
          icon: hasText
              ? const Icon(Icons.clear, color: MainTheme.thirdColor)
              : const SizedBox(),
        );
      },
    );
  }

  Widget _buildDateInput() {
    return TextFormField(
      controller: _dateController,
      focusNode: _dateFocusNode,
      style: const TextStyle(color: MainTheme.thirdColor),
      decoration: InputDecoration(
        labelText: 'Date Validate',
        labelStyle: const TextStyle(color: MainTheme.thirdColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        filled: true,
        fillColor: MainTheme.secondaryColor,
      ),
      keyboardType: TextInputType.datetime,
      onChanged: (value) {
        final newText = _formatDate(value);
        if (newText != value) {
          _dateController.text = newText;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter date';
        }
        if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
          return 'Invalid date format. Please use dd/mm';
        }
        return null;
      },
    );
  }

  String _formatDate(String value) {
    if (value.length < 3) {
      return value;
    }
    final formattedDate = value.substring(0, 2) + "/" + value.substring(3, 5);
    return formattedDate.length > 5
        ? formattedDate.substring(0, 5)
        : formattedDate;
  }

  Widget _buildImageInput() {
    return TextFormField(
      readOnly: true,
      onTap: () => _takePicture(context),
      style: const TextStyle(color: MainTheme.thirdColor),
      decoration: InputDecoration(
        labelText: 'Picture of License: $_pickedImageName',
        labelStyle: const TextStyle(color: MainTheme.thirdColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        suffixIcon: const Icon(Icons.camera_alt),
        filled: true,
        fillColor: MainTheme.secondaryColor,
      ),
    );
  }

  void _takePicture(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _pickedImage = image;
        _pickedImageName = File(image.path).path.split('/').last;
        _imagePath = image.path;
      });
    }
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate() && _pickedImage != null) {
      _uploadImageToStorage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select an image.'),
        ),
      );
    }
  }

  void _uploadImageToStorage() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref("users").child('valet').child(_pickedImageName);

    UploadTask uploadTask = ref.putFile(File(_imagePath));
    await uploadTask.whenComplete(() async {
      String imageUrl = await ref.getDownloadURL();

      try {
        // Retrieve UID
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser!.uid.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .update({
            'nationality': _nationalityController.text,
            'driverLicense': _driverLicenseController.text,
            'dateValidate': _dateController.text,
            'imageName': _pickedImageName,
            'imageUrl': imageUrl,
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          print('User UID not found');
        }
      } catch (error) {
        print('Error updating user data: $error');
      }
    });
  }
}
