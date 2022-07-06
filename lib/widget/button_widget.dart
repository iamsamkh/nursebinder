import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  var txt, value, clr, width, txtColor;

  Button({
    this.txt,
    this.value,
    this.clr,
    this.width,
    this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 59.h,
      decoration:
          BoxDecoration(color: clr, borderRadius: BorderRadius.circular(10)),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: Colors.transparent,
        child: Text(
          "${txt}",
          style: TextStyle(
            color: txtColor,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            fontSize: 18,
          ),
        ),
        onPressed: value,
      ),
    );
  }
}
