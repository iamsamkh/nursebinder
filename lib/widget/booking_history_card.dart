import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class BookingHistoryCard extends StatelessWidget {
  final String nurseImgUrl;
  final String nurseTitle;
  final String nurseType;
  final DateTime date;
  final int hourCount;
  final String orderStatus;

  const BookingHistoryCard(
      {Key? key,
      required this.nurseImgUrl,
      required this.nurseTitle,
      required this.nurseType,
      required this.date,
      required this.hourCount,
      required this.orderStatus, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 140,
            width: Get.width * 0.25,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: nurseImgUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, _) {
                    return const Icon(Icons.error);
                  },
                )),
          ),
          Container(
            width: Get.width * 0.63,
            height: 140,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: KSecondaryColor.withOpacity(0.1),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Text(
                            nurseTitle,
                            style: headingSmallKBlackLight,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Text(
                            nurseType,
                            style: paragraphText,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 29,
                        width: 82.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: KSecondaryColor,
                        ),
                        child: Center(
                            child: Text(
                          "Rebook",
                          style: WhiteMsg,
                        )))
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/Vector - 2022-03-21T010123.872.png",
                          height: 16.17,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                            width: Get.width * 0.15,
                            child: Text(
                              DateFormat('d MMMM yyyy').format(date),
                              style: smallWhiteText,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/Vector - 2022-03-21T010130.509.png",
                          height: 16.17,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                            width: Get.width * 0.1,
                            child: Text(
                              DateFormat('H:mm').format(date),
                              style: smallWhiteText,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/Vector - 2022-03-21T010136.145.png",
                          height: 16.17,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          width: Get.width * 0.1,
                          child: Text(
                            "$hourCount",
                            style: smallWhiteText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                          'Order Status: ',
                          style: paragraphText,
                        ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        SizedBox(
                            width: Get.width * 0.1,
                            child: Text(
                              orderStatus,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: orderStatus == 'Completed' ? Colors.green : orderStatus == 'Active' ? KOrragneColor : KErrorColor,
                                  fontFamily: "Roboto"),
                              overflow: TextOverflow.ellipsis,
                            )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
