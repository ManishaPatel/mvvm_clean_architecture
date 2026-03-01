import 'package:flutter/material.dart';

class CustomTextFieldRounded extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscure;
  final TextEditingController controller;

  const CustomTextFieldRounded({
    super.key,
    required this.label,
    required this.icon,
    this.obscure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.grey.shade600, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 2),
            ),
            contentPadding: const EdgeInsets.only(bottom: 10, top: 10),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
