import 'package:flutter/material.dart';

class CustomTextLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const CustomTextLabel({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: fontWeight,
              ),
              textAlign: textAlign,
            ),
          ],
        ),
      ],
    );
  }
}
