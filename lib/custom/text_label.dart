import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/theme.dart';

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
                color: MainTheme.secondaryColor,
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
