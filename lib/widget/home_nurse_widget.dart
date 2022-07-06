import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant.dart';

class NurseTypeCard extends StatefulWidget {
  const NurseTypeCard({this.img, this.title});

  final img;
  final title;

  @override
  State<NurseTypeCard> createState() => _NurseTypeCardState();
}

class _NurseTypeCardState extends State<NurseTypeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: KLightSkyColor,
                ),
                height: Get.height * 0.28,
                width: Get.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 66,
                      width: 66,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: KSecondaryColor),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            widget.img,
                            height: 45,
                          )),
                    ),
                    Text(
                      widget.title,
                      style: headingSmallGrey,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
