import 'package:flutter/material.dart';
import 'package:valetclub_valet/common/theme.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: MainTheme.secondaryColor,
      child: const Center(
        child: Text('Scan Screen'),
      ),
    );
  }
}
