import 'package:flutter/material.dart';

class RegistrationFieldModel extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const RegistrationFieldModel({
    super.key,
    required this.label,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        labelText: label,
        suffixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
