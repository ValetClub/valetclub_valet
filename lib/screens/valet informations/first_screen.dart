import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/custom/suivant_button.dart';
import 'package:valetclub_valet/screens/valet%20informations/second_screen.dart';

class InfoFirstScreen extends StatefulWidget {
  const InfoFirstScreen({
    super.key,
  });

  @override
  _InfoFirstScreenState createState() => _InfoFirstScreenState();
}

class _InfoFirstScreenState extends State<InfoFirstScreen> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String _selectedDay;
  late String _selectedMonth;
  late String _selectedYear;

  late FocusNode _countryFocusNode;
  late FocusNode _cityFocusNode;
  late FocusNode _addressFocusNode;

  @override
  void initState() {
    super.initState();

    _selectedDay = '1';
    _selectedMonth = 'January';
    _selectedYear = '2010';

    _countryFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _countryFocusNode.dispose();
    _cityFocusNode.dispose();
    _addressFocusNode.dispose();
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
                                "Registration",
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
              const SizedBox(height: 39),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDay,
                      items: List.generate(
                        31,
                        (index) => DropdownMenuItem<String>(
                          value: (index + 1).toString(),
                          child: Text((index + 1).toString()),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value!;
                        });
                      },
                      style: const TextStyle(color: MainTheme.thirdColor),
                      decoration: InputDecoration(
                        labelText: 'Day',
                        labelStyle:
                            const TextStyle(color: MainTheme.thirdColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        filled: true,
                        fillColor: MainTheme.secondaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select day';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedMonth,
                      items: [
                        for (var month in _getMonths())
                          DropdownMenuItem<String>(
                            value: month,
                            child: Text(month),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = value!;
                        });
                      },
                      style: const TextStyle(color: MainTheme.thirdColor),
                      decoration: InputDecoration(
                        labelText: 'Month',
                        labelStyle:
                            const TextStyle(color: MainTheme.thirdColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        filled: true,
                        fillColor: MainTheme.secondaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select month';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedYear,
                      items: List.generate(
                        100,
                        (index) => DropdownMenuItem<String>(
                          value: (2010 - index).toString(),
                          child: Text((2010 - index).toString()),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = value!;
                        });
                      },
                      style: const TextStyle(color: MainTheme.thirdColor),
                      decoration: InputDecoration(
                        labelText: 'Year',
                        labelStyle:
                            const TextStyle(color: MainTheme.thirdColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        filled: true,
                        fillColor: MainTheme.secondaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select year';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _countryController,
                focusNode: _countryFocusNode,
                style: const TextStyle(color: MainTheme.thirdColor),
                decoration: InputDecoration(
                  labelText: 'Country',
                  labelStyle: const TextStyle(color: MainTheme.thirdColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  filled: true,
                  fillColor: MainTheme.secondaryColor,
                  suffixIcon: _buildClearIconButton(
                      _countryController, _countryFocusNode),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_cityFocusNode);
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                focusNode: _cityFocusNode,
                style: const TextStyle(color: MainTheme.thirdColor),
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: const TextStyle(color: MainTheme.thirdColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  filled: true,
                  fillColor: MainTheme.secondaryColor,
                  suffixIcon:
                      _buildClearIconButton(_cityController, _cityFocusNode),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_addressFocusNode);
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                focusNode: _addressFocusNode,
                style: const TextStyle(color: MainTheme.thirdColor),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: MainTheme.thirdColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  filled: true,
                  fillColor: MainTheme.secondaryColor,
                  suffixIcon: _buildClearIconButton(
                      _addressController, _addressFocusNode),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String dateOfBirth =
                              '$_selectedDay $_selectedMonth $_selectedYear';

                          try {
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
                            if (currentUser!.uid.isNotEmpty) {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(currentUser.uid)
                                  .update({
                                'dateOfBirth': dateOfBirth,
                                'country': _countryController.text,
                                'city': _cityController.text,
                                'address': _addressController.text,
                              });
                            } else {
                              print('User UID not found ');
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InfoSecondScreen(),
                              ),
                            );
                          } catch (e) {
                            print('Error updating user data: $e');
                          }
                        }
                      },
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

  List<String> _getMonths() {
    return [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
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
}
