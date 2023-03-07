import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonSave extends StatelessWidget {
  final String? judul;
  final VoidCallback? onPressed;
  const CustomButtonSave({super.key, this.judul, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF4E31AA),
      ),
      child: Text(
        judul!,
        style: GoogleFonts.montserrat(
          fontSize: 16, fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
