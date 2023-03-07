import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? judul;
  const CustomButton({super.key, this.judul, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.yellow,
      borderRadius: BorderRadius.circular(8.0),
      child: Ink(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1.3,
            spreadRadius: 1.3,
            offset: Offset(1, 3),
          )
        ]),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width/3,
          margin: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              judul!,
              style: TextStyle(
                color: Color(0xff3A1078),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
