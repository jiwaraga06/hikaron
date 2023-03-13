import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1078),
        elevation: 0.0,
        title: Text('Notifkasi', style: GoogleFonts.montserrat()),
      ),
    );
  }
}
