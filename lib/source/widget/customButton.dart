import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final TextStyle? textStyle;
  final Color? splashColor, btnColor;
  const CustomButton({super.key, this.title, this.onTap, this.textStyle, this.splashColor, this.btnColor});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: splashColor,
      borderRadius: BorderRadius.circular(8.0),
      child: Ink(
        decoration: BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(8.0), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1.3,
            spreadRadius: 1.3,
            offset: const Offset(1, 3),
          )
        ]),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 3,
          margin: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(title!, style: textStyle),
          ),
        ),
      ),
    );
  }
}
