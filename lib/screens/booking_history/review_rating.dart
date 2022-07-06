import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/screens/booking_history/booking_history_controller.dart';

import '../../constant.dart';
import '../../widget/button_widget.dart';

class ReviewRating extends GetView<BookingHistoryController> {
  const ReviewRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nurseId = Get.arguments['nurseId'];
    final bookingId = Get.arguments['bookingId'];

    List<String> tip = ['5', '10', 'Custom'];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
        elevation: 0,
        title: Text(
          "Review & Rating",
          style: appBarHeading,
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/arrow-left.png",
                height: 24,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: controller.nurses[nurseId]!.imgUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, _) {
                          return const Icon(Icons.error);
                        },
                      )),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  controller.nurses[nurseId]!.nurseTitle,
                  style: appBarHeading,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  controller.nurses[nurseId]!.nurseType,
                  style: textStyle,
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: KSecondaryColor.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Text(
                    "How was your experience ?",
                    style: appBarHeading,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        ignoreGestures: controller.isReviewed,
                        initialRating: controller.ratings,
                        minRating: 1,
                        itemSize: 30,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: KSecondaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          controller.ratings = rating;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Tell us what can be improved ?",
              style: appBarHeading,
            ),
            SizedBox(
              height: 20.h,
            ),
            GetBuilder<BookingHistoryController>(
                id: 'services',
                builder: (cont) {
                  return SizedBox(
                    height: 120.h,
                    child: GridView.builder(
                      itemCount: cont.getImporvements.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: Get.width * 0.29,
                          childAspectRatio: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (!controller.isReviewed) {
                              cont.getImporvements[index]
                                      [cont.getImporvements[index].keys.first] =
                                  !cont.getImporvements[index].values.first;
                              cont.update(['services']);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: Get.width * 0.29,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: cont.getImporvements[index].values.first
                                  ? KSecondaryColor
                                  : KWhiteLightColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                cont.getImporvements[index].keys.first,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        cont.getImporvements[index].values.first
                                            ? KWhiteColor
                                            : KBlackLightColor,
                                    fontFamily: "Roboto"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Would you like to give tip ?",
              style: appBarHeading,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            GetBuilder<BookingHistoryController>(
                id: 'tip',
                builder: (_) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: GridView.builder(
                          itemCount: tip.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: Get.width * 0.29,
                                  childAspectRatio: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (!controller.isReviewed) {
                                  if (_.tipAmount == tip[index]) {
                                    _.tipAmount = '0';
                                  } else {
                                    _.tipAmount = tip[index];
                                  }
                                  _.update(['tip']);
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: Get.width * 0.29,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: _.tipAmount == tip[index]
                                      ? KSecondaryColor
                                      : KWhiteLightColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    tip[index] == 'Custom'
                                        ? tip[index]
                                        : '\$${tip[index]}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: _.tipAmount == tip[index]
                                            ? KWhiteColor
                                            : KBlackLightColor,
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (_.tipAmount == 'Custom')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: TextField(
                            controller: _.customTipController,
                            readOnly: controller.isReviewed,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Custom Tip',
                            ),
                            onChanged: (value) {
                              _.tipAmount = value;
                            },
                          ),
                        )
                    ],
                  );
                }),
            SizedBox(
              height: 20.h,
            ),

            // SizedBox(height: 20.h,),
            Text(
              "Comment & Feedback",
              style: appBarHeading,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: KBlackLightColor, width: 2)),
              child: TextField(
                readOnly: controller.isReviewed,
                controller: controller.feedback,
                style: headingSmallGrey,
                cursorColor: KGreyColor,
                maxLines: 10,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.h, horizontal: 23),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            height: 80,
            child: Column(
              children: [
                Button(
                  txtColor: KPrimaryColor,
                  txt: controller.isReviewed ? "Already Reviewed" : "Submit",
                  width: Get.width,
                  clr: controller.isReviewed ? KGreenColor : KSecondaryColor,
                  value: () async {
                    if (!controller.isReviewed) {
                      try {
                        await controller.submitReview(nurseId, bookingId);
                        Navigator.of(context).pop();
                        Get.showSnackbar(
                          const GetSnackBar(
                            message: 'Review submitted Successfully!',
                            backgroundColor: KGreenColor,
                            isDismissible: true,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (_) {
                        Get.showSnackbar(
                          const GetSnackBar(
                            message:
                                'Ops! Unable to submit review this time. Please try again...',
                            backgroundColor: KOrragneColor,
                            isDismissible: true,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            )),
      ),
    ));
  }
}
