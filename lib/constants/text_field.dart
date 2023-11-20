import 'package:flutter/material.dart';

class TextFielWidget extends StatefulWidget {
  const TextFielWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.icon,
    required this.title,
    required this.isTrailing,
  });
  final bool isTrailing;
  final IconData icon;
  final String? Function(String?) validator;
  final String title;
  final TextEditingController controller;

  @override
  State<TextFielWidget> createState() => _TextFielWidgetState();
}

class _TextFielWidgetState extends State<TextFielWidget> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isVisible,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          prefixIcon: Icon(widget.icon),
          hintText: widget.title,
          suffixIcon: widget.isTrailing
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: isVisible
                      ? const Icon(Icons.visibility)
                      : Icon(Icons.visibility_off))
              : null,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
