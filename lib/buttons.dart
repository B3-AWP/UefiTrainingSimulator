import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text, style: const TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
    );
  }
}