import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReclamationScreen extends StatefulWidget {
  const ReclamationScreen({super.key});

  @override
  _ReclamationScreenState createState() => _ReclamationScreenState();
}

class _ReclamationScreenState extends State<ReclamationScreen> {
  final _controller = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  DateTime? _selectedDate;
  String? _typeOfReclamation;
  String? _explicationOfProblem;
  late String _pickedImageName;
  late String _imagePath;
  late XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _pickedImageName = '';
    _imagePath = '';
  }

  void _addMessage(String text, {String sender = 'user'}) {
    setState(() {
      _messages.insert(0, ChatMessage(text: text, sender: sender));
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _addMessage(_controller.text, sender: 'user');
      _controller.clear();
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showTypeOfReclamationDropdown() async {
    final List<String> types = ['Type 1', 'Type 2', 'Type 3'];
    final String? selectedType = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Type of Reclamation'),
          children: types.map((String type) {
            return SimpleDialogOption(
              child: Text(type),
              onPressed: () {
                Navigator.pop(context, type);
              },
            );
          }).toList(),
        );
      },
    );

    if (selectedType != null) {
      setState(() {
        _typeOfReclamation = selectedType;
      });
    }
  }

  void _showExplicationOfProblemDropdown() async {
    final List<String> explanations = [
      'Explanation 1',
      'Explanation 2',
      'Explanation 3'
    ];
    final String? selectedExplanation = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Explanation of Problem'),
          children: explanations.map((String explanation) {
            return SimpleDialogOption(
              child: Text(explanation),
              onPressed: () {
                Navigator.pop(context, explanation);
              },
            );
          }).toList(),
        );
      },
    );

    if (selectedExplanation != null) {
      setState(() {
        _explicationOfProblem = selectedExplanation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reclamations',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: MainTheme.secondaryColor,
        foregroundColor: MainTheme.darkColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: MainTheme.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: _selectDate,
                        child: Text(_selectedDate == null
                            ? 'Select date'
                            : DateFormat.yMMMMd('en_US')
                                .format(_selectedDate!)),
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: _typeOfReclamation,
                        decoration: const InputDecoration(
                          labelText: 'Type of Reclamation',
                        ),
                        onChanged: (String? newValue) {
                          _showTypeOfReclamationDropdown();
                        },
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Select type of reclamation'),
                          ),
                          ...['Type 1', 'Type 2', 'Type 3'].map((String type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: _explicationOfProblem,
                        decoration: const InputDecoration(
                          labelText: 'Explanation of Problem',
                        ),
                        onChanged: (String? newValue) {
                          _showExplicationOfProblemDropdown();
                        },
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Select explanation of problem'),
                          ),
                          ...['Explanation 1', 'Explanation 2', 'Explanation 3']
                              .map((String explanation) {
                            return DropdownMenuItem(
                              value: explanation,
                              child: Text(explanation),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _buildImageInput(),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _sendMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainTheme.mainColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Write a comment',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      filled: true,
                      fillColor: MainTheme.greyColor.withOpacity(0.3),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageInput() {
    return TextFormField(
      readOnly: true,
      onTap: () => _takePicture(context),
      style: const TextStyle(color: MainTheme.thirdColor),
      decoration: InputDecoration(
        labelText: 'Joinez des videos/Photos: $_pickedImageName',
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
}

class ChatMessage {
  final String text;
  final String sender;

  ChatMessage({required this.text, required this.sender});
}
