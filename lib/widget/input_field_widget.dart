import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nurse_binder/constant.dart';

class InputField extends StatefulWidget {
  InputField({
    this.controller,
    this.hidden,
    this.readonly,
  });

  final controller;
  final hidden;
  final readonly;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readonly,
      obscureText: widget.hidden,
      controller: widget.controller,
      style: headingSmallGrey,
      cursorColor: KGreyColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 23),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            width: 1,
            color: KWhiteLightColor,
          ),
        ),
        // hintStyle: hintStyle,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            width: 2,
            color: KSecondaryColor,
          ),
        ),
      ),
    );
  }
}

class BottomTextField extends StatefulWidget {
  BottomTextField({
    this.hintTxt,
    this.controller,
    this.value,
  });

  final hintTxt;
  final value;
  final controller;

  @override
  _BottomTextFieldState createState() => _BottomTextFieldState();
}

class _BottomTextFieldState extends State<BottomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.value,
      controller: widget.controller,
      style: headingSmallGrey,
      cursorColor: KGreyColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 23),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            width: 1,
            color: KWhiteLightColor,
          ),
        ),
        hintText: widget.hintTxt,
        hintStyle: GreyLightTextStyle,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
            width: 2,
            color: KSecondaryColor,
          ),
        ),
      ),
    );
  }
}
