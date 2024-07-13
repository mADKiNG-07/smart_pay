import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextArea extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final obscureText;
  final void Function(dynamic)? onChanged;
  final TextInputType? keyboardType;

  CustomTextArea({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
          borderSide: BorderSide(
            color: Color.fromRGBO(47, 162, 185, 1),
          ),
        ),
        filled: true,
        fillColor: Color.fromRGBO(249, 250, 251, 1),
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(156, 163, 175, 1)),
      ),
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      cursorColor: Colors.black,
    );
  }
}
