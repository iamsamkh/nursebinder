import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nurse_binder/navigators/navigators.dart';
import 'package:nurse_binder/screens/home/home.dart';

import '../../../../constant.dart';
import '../../../widget/button_widget.dart';
import '../../booking/booking_view.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    id: 'payment',
    builder: ((controller) => SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          elevation: 0,
          title: Text(
            "Select Payment",
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
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  // Get.to(NurseInfoDetail(),transition: Transition.leftToRight);
                },
                child: Card(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: KWhiteColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      leading: SizedBox(
                          height: 52,
                          width: 52,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: controller
                                    .nurseData[controller.currentNurseSelection]
                                    .imgUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, error, _) {
                                  return const Icon(Icons.error);
                                },
                              ))),
                      title: Text(
                        controller.nurseData[controller.currentNurseSelection]
                            .nurseTitle,
                        style: headingSmallKBlackLight,
                      ),
                      subtitle: Text(
                        controller.nurseData[controller.currentNurseSelection]
                            .nurseType,
                        style: smaltext,
                      ),
                      trailing: SizedBox(
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
                                '${controller.nurseData[controller.currentNurseSelection].rating['avgrating']}',
                                style: smaltext),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Text(
                "Payment Options",
                style: headingSmallKBlackLight,
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: KWhiteLightColor)),
                  child: ListTile(
                    leading: Radio(
                      hoverColor: KGreyColor,
                      activeColor: KSecondaryColor,
                      value: 'Card Payment',
                      groupValue: controller.paymentType,
                      onChanged: (val) {
                        controller.paymentType = val.toString();
                        controller.update(['payment']);
                      },
                    ),
                    title: const Text("Card Payment"),
                    trailing: Image.asset(
                      "assets/pngaaa 2.png",
                      height: 15,
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: KWhiteLightColor)),
                  child: ListTile(
                    leading:  Radio(
                      hoverColor: KGreyColor,
                      activeColor: KSecondaryColor,
                      value: 'Paypal',
                      groupValue: controller.paymentType,
                      onChanged: (val) {
                        controller.paymentType= val.toString();
                        controller.update(['payment']);
                      }
                    ),
                    title: const Text("Paypal"),
                    trailing: Image.asset(
                      "assets/image 10.png",
                      height: 15,
                    ),
                  )),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Summary Of Booking",
                style: headingSmallKBlackLight,
              ),
              SizedBox(
                height: 23.h,
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                          controller.address.value,
                          style: paragraphText,
                        ),
                        trailing: SizedBox(
                          width: 120,
                          child: Text(
                            
                            DateFormat('d MMMM yyyy - H:mm').format(controller.generateBookingDate.toDate()),
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
                                imageUrl: controller
                                    .nurseData[controller.currentNurseSelection]
                                    .imgUrl,
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
                              controller.nurseData[controller.currentNurseSelection].nurseTitle,
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
                                '${controller.nurseData[controller.currentNurseSelection].rating['avgrating']}',
                                style: smaltext),
                          ],
                        ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        controller.nurseData[controller.currentNurseSelection].nurseType,
                        style: smaltext,
                      ),
                      trailing: SizedBox(
                        width: 60,
                        child: Text(
                          "\$${controller.nurseData[controller.currentNurseSelection].hourlyRate}/Hour",
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
                          child: Text(
                            "Additional Fee: \$${controller.additionalFee}",
                            style: headingSmallGrey,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.4,
                          height: 45.h,
                          decoration: const BoxDecoration(
                            color: KBlackLightColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Total \$${controller.generateTotal().toDouble()}",
                            style: whiteSimpleText,
                          )),
                        )
                      ],
                    )
                  ],
                ),
              )
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
                    txt: "Book Now",
                    width: Get.width,
                    clr: KSecondaryColor,
                    value: () async{
                      try{
                        if(controller.paymentType == 'Card Payment') {
                    await controller.makePayment();
                  } else {
                    final result = await RouteManagement.goToPaypal();
                    final snackBar;
                    if(result !=null) {
                      snackBar = const GetSnackBar(
                        message: 'Payment Successful',
                        isDismissible: true,
                        duration: Duration(seconds: 2),
                      );
                      final bookingId = await Get.showOverlay(asyncFunction: controller.trybooking, loadingWidget: const Center(child: CircularProgressIndicator(),));
                        RouteManagement.goToBooking(bookingId);
                    } else {
                      snackBar = const GetSnackBar(
                        message: 'Payment Unsuccessful',
                        isDismissible: true,
                        duration: Duration(seconds: 2),
                      );
                    }
                    Get.showSnackbar(snackBar);
                  }
                      }catch(_){
                        Get.showSnackbar(
                          const GetSnackBar(
                            message:
                                'Booking error, Please try again....',
                            backgroundColor: KOrragneColor,
                            isDismissible: true,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ],
              )),
        ),
      ),
    )));
}
