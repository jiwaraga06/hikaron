import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormField extends StatelessWidget {
  final String? hint, label, msgError;
  final TextEditingController? controller;
  final bool? obSecureText;
  final Widget? iconLock, iconSuffix;
  final VoidCallback? showPass;
  final bool? iconPass, readOnly;
  CustomFormField({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.iconLock,
    this.showPass,
    this.iconPass,
    this.iconSuffix,
    this.msgError,
    this.obSecureText,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,
      obscureText: obSecureText!,
      controller: controller,
      cursorColor: Colors.deepPurple,
      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          errorStyle: GoogleFonts.inter(fontSize: 15),
          labelStyle: GoogleFonts.inter(color: Colors.deepPurple),
          prefixIcon: iconLock,
          suffixIcon: iconSuffix,
          hintStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0), borderSide: BorderSide(color: Colors.deepPurple)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0), borderSide: BorderSide(color: Colors.deepPurple)),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12.0),
          // ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 8)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return msgError;
        }
        return null;
      },
    );
  }
}
