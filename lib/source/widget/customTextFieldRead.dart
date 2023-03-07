import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormFieldRead extends StatelessWidget {
  final String? hint, label, msgError, m;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  CustomFormFieldRead({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.msgError,
    this.onTap,
    this.m,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      cursorColor: Colors.deepPurple,
      style: GoogleFonts.montserrat(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          errorStyle: GoogleFonts.montserrat(fontSize: 15),
          labelStyle: GoogleFonts.montserrat(
            color: Colors.deepPurple,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(8.0),borderSide: BorderSide(color: Colors.deepPurple)),
          suffix: Text(m ?? '')),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return msgError;
        }
        return null;
      },
    );
  }
}
