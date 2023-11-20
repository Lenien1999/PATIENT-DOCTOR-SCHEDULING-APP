import 'package:flutter/material.dart';

class TextFielWidget extends StatelessWidget {
  const TextFielWidget({
    super.key,
    required this.controller,
      this.validator,
    required this.icon,
    required this.title,
    required this.isTrailing,
  });
  final bool isTrailing;
  final IconData icon;
   final String Function(String?)? validator;
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          prefixIcon: Icon(icon),
          hintText: title,
          suffixIcon: isTrailing
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye_sharp))
              : null,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
