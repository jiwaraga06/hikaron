import 'package:flutter/material.dart';

class CustomButtonScan extends StatelessWidget {
  final VoidCallback? onTap;
  final String? judul;
  const CustomButtonScan({super.key, this.onTap, this.judul});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue,
      child: Ink(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.qr_code_sharp), Text(judul!)],
          ),
        ),
      ),
    );
  }
}
