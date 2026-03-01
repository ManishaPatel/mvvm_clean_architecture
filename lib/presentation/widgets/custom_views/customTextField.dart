import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String iconPath;
  final bool obscure;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.iconPath,
    this.obscure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        cursorColor: AppColor.white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColor.white,
            fontSize: 16,
          ),

          prefixIcon: Padding(
            padding:  EdgeInsets.all(12.0),
            child: Image.asset(
              iconPath,
              width: 16,
              height: 16,
              color: Colors.white,
            ),
          ),
          prefixIconConstraints:
          const BoxConstraints(minWidth: 40, minHeight: 40),

          border: const UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),

          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),

          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
