import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Icon prefixIcon;
  final String? errorText;
  final String labelText;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    this.errorText,
    required this.labelText
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        errorText: widget.errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
