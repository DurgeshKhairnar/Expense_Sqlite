import 'package:flutter/material.dart';

class CustomTextFild extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextFild({
    super.key,
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
    required this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 2.0,
            color: Color.fromARGB(255, 237, 236, 236),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2.0, color: Colors.green),
        ),
        prefixIcon:prefixIcon ,
        suffixIcon:suffixIcon
      ),
    );
  }
}
