import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nurse_binder/screens/booking/pages/chat_screen.dart';
import 'package:nurse_binder/screens/booking_history/review_rating.dart';

import '../../../constant.dart';
import '../../../widget/button_widget.dart';
import '../booking_controller.dart';

class BookingInformation extends GetView<BookingController> {
  bool selectOption = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          elevation: 0,
          title: Text(
            "Booking Information",
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
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: controller.nurseInfo!.imgUrl,
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
                    controller.nurseInfo!.nurseTitle,
                    style: appBarHeading,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    controller.nurseInfo!.nurseType,
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => ChatScreen());
                    },
                    child: SizedBox(
                      width: Get.width * 0.35,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/Vector - 2022-03-20T125627.924.png",
                            height: 18.h,
                            color: KBlackLightColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Chat Nurse",
                            style: smallTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    height: 39.h,
                    child: const VerticalDivider(
                      thickness: 3,
                      color: KGreyLightColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: Get.width * 0.35,
                    child: Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.0),
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            )),
                        Text('${controller.nurseInfo!.rating['avgrating']}',
                            style: smaltext),
                        SizedBox(
                          width: 7.w,
                        ),
                        Expanded(
                            child: Text(
                          "(${controller.nurseInfo!.rating['ratingCount']} Reviews)",
                          style: smaltext,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: KSecondaryColor.withOpacity(0.1),
                ),
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    ListTile(
                        minLeadingWidth: -4,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        leading: Container(
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: KGreyColor.withOpacity(0.3),
                            ),
                            width: 25,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Center(
                                  child: Image.asset(
                                    "assets/Vector - 2022-03-20T023352.887.png",
                                    height: 12.17,
                                  ),
                                ))),
                        title: Obx(() => Text(
                              controller.bookingInfo.value.bookingAddress,
                              style: paragraphText,
                            )),
                        trailing: SizedBox(
                          width: 120,
                          child: Text(
                            DateFormat('d MMMM yyyy - H:mm').format(controller.bookingInfo.value.appointmentTime.toDate()),
                            style: paragraphText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: KSecondaryColor.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    ListTile(
                        minLeadingWidth: -4,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        leading: Container(
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: KGreyColor.withOpacity(0.3),
                            ),
                            width: 25,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Center(
                                  child: Image.asset(
                                    "assets/Vector - 2022-03-20T141009.659.png",
                                    height: 12.17,
                                  ),
                                ))),
                        title: Text(
                          "${controller.bookingInfo.value.hours} Hours work",
                          style: paragraphText,
                        ),
                        trailing: SizedBox(
                          width: 120,
                          child: Text(
                            "\$${controller.bookingInfo.value.totalAmount} (${controller.bookingInfo.value.paymentMethod})",
                            style: paragraphText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.33,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/image 1.png",
                          height: 150.h, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Column(
                      children: [
                        NurseMap(
                          subtitle: "29 April 2021, 17:00",
                          title: "Nurse on the way",
                          img: "assets/Vector - 2022-03-20T172128.706.png",
                        ),
                        NurseMap(
                          subtitle: "29 April 2021, 17:00",
                          title: "Nurse Almost Arrive",
                          img: "assets/Vector - 2022-03-20T171920.096.png",
                        ),
                        GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   selectOption = !selectOption;
                            // });
                          },
                          child: Container(
                            width: Get.width * 0.5,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: selectOption
                                                  ? KSecondaryColor
                                                  : KGreyColor.withOpacity(0.3),
                                            ),
                                            width: 40,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/verified (1).png",
                                                    height: 12.17,
                                                  ),
                                                ))),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Get.width * 0.35,
                                          child: Text(
                                            "Nurse Arrive",
                                            style: GreyLightTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          width: Get.width * 0.3,
                                          child: Text(
                                            "29 April 2021, 17:20",
                                            style: smallWhiteText,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Visibility(
                visible: selectOption,
                child: Button(
                  txtColor: KPrimaryColor,
                  txt: "Give Rating",
                  width: Get.width,
                  clr: KYellowColor,
                  value: () {
                    Get.to(ReviewRating(), transition: Transition.leftToRight);
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NurseMap extends StatefulWidget {
  const NurseMap({this.title, this.img, this.subtitle});

  final title;
  final img;
  final subtitle;

  @override
  State<NurseMap> createState() => _NurseMapState();
}

class _NurseMapState extends State<NurseMap> {
  bool selectOption = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectOption = !selectOption;
        });
      },
      child: Container(
        width: Get.width * 0.5,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: selectOption
                              ? KSecondaryColor
                              : KGreyColor.withOpacity(0.3),
                        ),
                        width: 40,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                              child: Image.asset(
                                widget.img,
                                height: 12.17,
                              ),
                            ))),
                    Container(
                      height: 60.h,
                      child: VerticalDivider(
                        color: selectOption
                            ? KSecondaryColor
                            : KGreyColor.withOpacity(0.3),
                        thickness: 3,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.35,
                      child: Text(
                        widget.title,
                        style: GreyLightTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: Get.width * 0.3,
                      child: Text(
                        widget.subtitle,
                        style: smallWhiteText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
