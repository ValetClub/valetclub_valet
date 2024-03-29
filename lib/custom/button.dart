import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/theme.dart';

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
    this.buttonColor = MainTheme.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: isLoading
            ? const CircularProgressIndicator(color: MainTheme.secondaryColor)
            : MaterialButton(
                onPressed: onPressed,
                color: buttonColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: MainTheme.secondaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                child: Text(
                  buttonText,
                  style: const TextStyle(color: MainTheme.secondaryColor),
                ),
              ),
      ),
    );
  }
}
