import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class UpcomeingBooking extends StatelessWidget {
  final String nurseTitle;
  final String nurseImgUrl;
  final String nurseType;
  final DateTime bookingDate;
  const UpcomeingBooking(
    this.nurseTitle,
    this.nurseImgUrl,
    this.nurseType,
    this.bookingDate, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.only(top: 15.h, left: 15.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: KSecondaryColor.withOpacity(0.1),
            ),
            width: Get.width * 0.75,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: ListTile(
              isThreeLine: true,
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: nurseImgUrl,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))),
              title: Text(
                'Time: ${DateFormat('d MMMM yyyy - H:mm').format(bookingDate)}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: KGreyColor,
                    fontFamily: "Roboto"),
              ),
              subtitle: Text(
                // nurseType,
                '$nurseTitle\n$nurseType',
                //         .format(bookingDate),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KBlackLightColor,
                    fontFamily: "Roboto"),
              ),
              // trailing: SizedBox(
              //   width: 120,
              //   child: Text(
              //     DateFormat('d MMMM yyyy - H:mm')
              //         .format(bookingDate),
              //     style: paragraphText,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // )
            ),
          ),
        ),
      ],
    );
  }
}
