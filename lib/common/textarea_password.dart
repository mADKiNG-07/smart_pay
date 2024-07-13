import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable, camel_case_types
class CustomTextArea_Password extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  bool obscureText;

  CustomTextArea_Password({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  });

  @override
  State<CustomTextArea_Password> createState() =>
      _CustomTextArea_PasswordState();
}

class _CustomTextArea_PasswordState extends State<CustomTextArea_Password> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            widget.obscureText ? Icons.visibility : Icons.visibility_off,
            color: Color.fromRGBO(107, 114, 128, 1),
          ),
          // Based on passwordVisible state choose the icon
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              widget.obscureText = !widget.obscureText;
            });
          },
        ),
        contentPadding: const EdgeInsets.all(16),
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
        hintText: widget.hintText,
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
