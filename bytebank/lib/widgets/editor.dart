import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  const Editor({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
