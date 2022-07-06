import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';

class TopNurseCard extends StatelessWidget {
  final String title;
  final String type;
  final String imgUrl;
  final dynamic rating;
  const TopNurseCard(
      {Key? key,
      required this.title,
      required this.type,
      required this.imgUrl,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
              height: 52,
              width: 52,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))),
          title: Text(
            title,
            style: headingSmallKBlackLight,
          ),
          subtitle: Text(
            type,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: KGreyColor,
                fontFamily: "Roboto"),
          ),
          // trailing: SizedBox(
          //   width: 30,
          //   child: Row(
          //     children: [
          //       Icon(
          //           Icons.star,
          //           color: Colors.amber,
          //           semanticLabel: '$rating',
          //           size: 20,
          //         ),
          //       Text('$rating',style: textStyle)
          //     ],
          //   )
          //   ),
          trailing: SizedBox(
            width: 100,
            child: RatingBar.builder(
              ignoreGestures: true,
              initialRating: rating.toDouble(),
              minRating: 1,
              itemSize: 18,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                //
              },
            ),
          ),
        ));
    //
  }
}
