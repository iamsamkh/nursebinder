import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/screens/home/home.dart';
import 'package:nurse_binder/screens/home/pages/payment.dart';
import 'package:nurse_binder/widget/review_card.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../constant.dart';
import '../../../../widget/button_widget.dart';
import '../../../widget/ability_card.dart';

class NurseInfoDetail extends StatelessWidget {
  const NurseInfoDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      id: 'nurseInfoDetail',
      builder: ((controller) => SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: KPrimaryColor,
              elevation: 0,
              title: Text(
                "Nurse Information",
                style: appBarHeading,
              ),
              centerTitle: true,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(result: 'Sameer');
                    },
                    child: Image.asset(
                      "assets/arrow-left.png",
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: KSecondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: controller
                                        .nurseData[
                                            controller.currentNurseSelection]
                                        .imgUrl,
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
                              controller
                                  .nurseData[controller.currentNurseSelection]
                                  .nurseTitle,
                              style: appBarHeading,
                            ),
                            Text(
                              controller
                                  .nurseData[controller.currentNurseSelection]
                                  .nurseType,
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Experience of work",
                        style: headingSmallGrey,
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: KSecondaryColor.withOpacity(0.1),
                        ),
                        child: Text(
                          "${controller.nurseData[controller.currentNurseSelection].totalExperience} Years",
                          style: headingSmallKBlackLight,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Education",
                        style: headingSmallGrey,
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: KSecondaryColor.withOpacity(0.1),
                        ),
                        child: Text(
                          controller.nurseData[controller.currentNurseSelection]
                              .totalEducation,
                          style: headingSmallKBlackLight,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Ability / Skill",
                        style: headingSmallGrey,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                          height: 120,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: KSecondaryColor.withOpacity(0.1),
                          ),
                          child: Scrollbar(
                            thickness: 3,
                            controller: controller.scrollController,
                            child: ListView.builder(
                                controller: controller.scrollController,
                                itemCount: controller
                                    .nurseData[controller.currentNurseSelection]
                                    .skillList
                                    .length,
                                itemBuilder: ((context, index) {
                                  return AbilityCard(
                                    txt: controller
                                        .nurseData[
                                            controller.currentNurseSelection]
                                        .skillList[index],
                                  );
                                })),
                          )),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Reviews",
                        style: headingSmallGrey,
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: GetX<HomeController>(builder: (cont) {
                    if (cont.nurseReviews.isEmpty && cont.hasReviews == true) {
                      return const Center(child: CircularProgressIndicator());
                    } else if(cont.nurseReviews.isEmpty && cont.hasReviews == false){
                      return Center(child: Text('No Reviews Yet...', style: headingSmallGrey,),);
                    }
                    else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cont.nurseReviews.length,
                        itemBuilder: (context, index) {
                          return ReviewCard(
                              facilityTitle: cont
                                  .getFacilityData[
                                      cont.nurseReviews[index].facilityId]!
                                  .fName,
                              facilityImgUrl: cont
                                  .getFacilityData[
                                      cont.nurseReviews[index].facilityId]!
                                  .imgUrl,
                              rating: cont.nurseReviews[index].rating,
                              reviewText: cont.nurseReviews[index].comment);
                        },
                      );
                    }
                  }),
                ),
                Text(
                  "Choose Booking Date",
                  style: headingSmallGrey,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                  height: Get.height * 0.55,
                  child: SfDateRangePicker(
                    headerStyle: const DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          color: KBlackLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    selectionMode: DateRangePickerSelectionMode.single,
                    minDate: controller.getServerTime,
                    selectionColor: KSecondaryColor,
                    onSelectionChanged: (date) {
                      controller.dateSelection = date.value.day;
                    },
                    rangeTextStyle: const TextStyle(color: KWhiteColor),
                    todayHighlightColor: KSecondaryColor,
                    selectionTextStyle: const TextStyle(
                      color: KWhiteColor,
                    ),
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(
                          color: KGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Poppins-Medium',
                        )),
                        weekNumberStyle: DateRangePickerWeekNumberStyle(
                            backgroundColor: KPrimaryColor)),
                    monthCellStyle: const DateRangePickerMonthCellStyle(
                        todayTextStyle: TextStyle(
                          color: KGreyColor,
                          decorationColor: KSecondaryColor,
                        ),
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: KBlackLightColor,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 24 - controller.getServerTime.hour,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.timeSelection =
                              index + 1 + controller.getServerTime.hour;
                          controller.update(['nurseInfoDetail']);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: controller.timeSelection ==
                                    index + 1 + controller.getServerTime.hour
                                ? KSecondaryColor
                                : KSecondaryColor.withOpacity(0.1),
                          ),
                          child: Text(
                            '${index + 1 + controller.getServerTime.hour}:00',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: controller.timeSelection ==
                                        index +
                                            1 +
                                            controller.getServerTime.hour
                                    ? KPrimaryColor
                                    : KBlackLightColor,
                                fontFamily: "Roboto"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.hourCountSelection = index + 1;
                          controller.update(['nurseInfoDetail']);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: controller.hourCountSelection == index + 1
                                ? KSecondaryColor
                                : KSecondaryColor.withOpacity(0.1),
                          ),
                          child: Text(
                            '${index + 1} Hours',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    controller.hourCountSelection == index + 1
                                        ? KPrimaryColor
                                        : KBlackLightColor,
                                fontFamily: "Roboto"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
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
                        txt: "Select Nurse",
                        width: Get.width,
                        clr: KSecondaryColor,
                        value: () {
                          if (controller.currentNurseSelection == -1 ||
                              controller.dateSelection == -1 ||
                              controller.timeSelection == -1 ||
                              controller.hourCountSelection == -1) {
                            Get.showSnackbar(
                              const GetSnackBar(
                                message: 'All Fields are required',
                                isDismissible: true,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          } else {
                            Get.to(() => Payment(),
                                transition: Transition.leftToRight);
                          }
                        },
                      ),
                    ],
                  )),
            ),
          ))));
}
