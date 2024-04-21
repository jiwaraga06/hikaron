import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton2 extends StatelessWidget {
  final String? judul;
  final VoidCallback? onPressed;
  final TextStyle? style;
  const CustomButton2({super.key, this.judul, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: Color(0xFFB46060),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
      ),
      child: Text(
        judul!,
        style: style ?? GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
