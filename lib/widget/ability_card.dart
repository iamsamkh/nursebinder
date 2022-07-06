import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';

class AbilityCard extends StatelessWidget {
  final txt;
  const AbilityCard({ Key? key, this.txt }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: KBlackLightColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
              child: Text(
            txt,
            style: paragraphText,
          ))
        ],
      ),
    );
  }
}