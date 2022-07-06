import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nurse_binder/navigators/navigators.dart';
import 'package:nurse_binder/screens/booking/pages/booking_information.dart';
import 'package:nurse_binder/screens/booking/pages/chat_screen.dart';
import 'package:nurse_binder/screens/screens.dart';

import '../../constant.dart';
import '../../widget/button_widget.dart';

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<BookingController>(
      builder: ((controller) => SafeArea(
              child: Scaffold(
            body:  Obx(() => controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) : Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Image.asset(
                    "assets/checked 1.png",
                    height: 230.h,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Booking Succesful!",
                    style: appBarHeading,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GetX<BookingController>(
                    builder: (_) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: KSecondaryColor.withOpacity(0.1),
                    ),
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        ListTile(
                            minLeadingWidth: -4,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            leading: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: KSecondaryColor.withOpacity(0.3),
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
                            title: Text(
                              _.bookingInfo.value.bookingAddress,
                              style: paragraphText,
                            ),
                            trailing: SizedBox(
                              width: 120,
                              child: Text(
                                DateFormat('d MMMM yyyy - H:mm').format(_.bookingInfo.value.appointmentTime.toDate()),
                                style: paragraphText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                imageUrl: _.nurseInfo
                                    !.imgUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, error, _) {
                                  return const Icon(Icons.error);
                                },
                              ))),
                          visualDensity: const VisualDensity(
                            vertical: -4,
                          ),
                          title: Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.3,
                                child: Text(
                                  _.nurseInfo
                                    !.nurseTitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: headingSmallGrey,
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                width: 50,
                                child: Row(
                                  children: [
                                    const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                )),
                            Text(
                                '${_.nurseInfo!.rating['avgrating']}',
                                style: smaltext),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            _.nurseInfo!.nurseType,
                            style: smaltext,
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: Text(
                              "\$${_.nurseInfo!.hourlyRate}/Hour",
                              style: paragraphText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => BookingInformation(),
                                      transition: Transition.leftToRight);
                                },
                                child: Text(
                                  "View Booking detail",
                                  style: underlineText,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ChatScreen());
                              },
                              child: Container(
                                width: Get.width * 0.47,
                                height: 45.h,
                                decoration: const BoxDecoration(
                                  color: KSecondaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/Vector - 2022-03-20T125627.924.png",
                                      height: 18,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                      "Chat Nurse",
                                      style: whiteSimpleText,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),),
                  
                  SizedBox(
                    height: 35.h,
                  ),
                  SizedBox(
                      child: Column(
                    children: [
                      Button(
                        txtColor: KPrimaryColor,
                        txt: "Back to home",
                        width: Get.width,
                        clr: KSecondaryColor,
                        value: () {
                          RouteManagement.goToHome();
                        },
                      ),
                    ],
                  )),
                ],
              ),
            ))
          ))));
}
