import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final bool isLoading;
  final Color buttonColor;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
    this.buttonColor = const Color(0xFFE23777),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : MaterialButton(
                onPressed: onPressed,
                color: buttonColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
