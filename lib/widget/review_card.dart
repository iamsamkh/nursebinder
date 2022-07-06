import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant.dart';

class ReviewCard extends StatelessWidget {
  final String facilityTitle;
  final String facilityImgUrl;
  final double rating;
  final String reviewText;
  const ReviewCard({ Key? key, required this.facilityTitle, required this.facilityImgUrl, required this.rating, required this.reviewText }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: Get.width * 0.76,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: KBlackLightColor),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                    height: 52,
                    width: 52,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                                    imageUrl: facilityImgUrl,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, _) {
                                      return const Icon(Icons.error);
                                    },
                                  ))),
                title: Text(
                  facilityTitle,
                  style: headingSmallKBlackLight,
                ),
                subtitle: SizedBox(
                  width: 100,
                  child: RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: rating,
                    minRating: rating,
                    itemSize: 15,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (_) {
                    },
                  ),
                ),
              ),
              Text(
                reviewText,
                style: paragraphText,
              )
            ],
          ),
        ),
      ],
    );
  }
}