import 'package:flutter/material.dart';

class CustomButtonScan extends StatelessWidget {
  final VoidCallback? onTap;
  final String? judul;
  final Color? backgroundColor, splashColor;
  const CustomButtonScan({super.key, this.onTap, this.judul, this.backgroundColor, this.splashColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: splashColor,
      child: Ink(
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
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
