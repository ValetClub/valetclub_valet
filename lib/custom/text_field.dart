import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valetclub_valet/common/theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  final TextInputType keyboardType;
  final bool isPassword;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode focusNode;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.prefixText,
    this.inputFormatters,
    this.validator,
    required this.focusNode,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _isObscure : false,
      keyboardType: widget.keyboardType,
      style: const TextStyle(color: MainTheme.thirdColor),
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        prefixText: widget.prefixText,
        prefixStyle: const TextStyle(color: MainTheme.thirdColor),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: MainTheme.thirdColor),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: MainTheme.thirdColor,
                ),
              )
            : _buildClearIconButton(widget.controller),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        filled: true,
        fillColor: MainTheme.secondaryColor,
      ),
      validator: widget.validator,
    );
  }

  Widget _buildClearIconButton(TextEditingController controller) {
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
