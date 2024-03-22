import 'package:flutter/material.dart';

class SuivantButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const SuivantButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: MaterialButton(
          onPressed: onPressed,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
