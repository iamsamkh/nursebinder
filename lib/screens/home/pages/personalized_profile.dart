import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nurse_binder/screens/screens.dart';
import '../../../../constant.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/input_field_widget.dart';

class PersonalizedProfile extends StatelessWidget {
  const PersonalizedProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<UploadPhotoController>(
      id: 'profile',
      builder: ((controller) => SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: KPrimaryColor,
              elevation: 0,
              title: Text(
                "Edit Profile",
                style: appBarHeading,
              ),
              centerTitle: true,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.pickedImage = null;
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
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.getImage();
                      },
                      child: Container(
                        height: 147,
                        width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipOval(
                          child: controller.pickedImage == null &&
                                  controller.currentUser == null && controller.auth!.photoURL == null
                              ? SizedBox(
                                  width: 147,
                                  child: Stack(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: KWhiteLightColor),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/user_photo_null.png",
                                            height: 147,
                                            width: 147,
                                          )),
                                      Positioned(
                                        bottom: 25,
                                        right: 15,
                                        child: Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: KGreenColor,
                                              border: Border.all(
                                                  color: KPrimaryColor,
                                                  width: 2)),
                                          child: Center(
                                              child: Image.asset(
                                            "assets/+ (1).png",
                                            height: 10,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : controller.currentUser == null && controller.auth!.photoURL == null ? 
                              SizedBox(
                                  width: 147,
                                  child: Stack(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: KWhiteLightColor),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/user_photo_null.png",
                                            height: 147,
                                            width: 147,
                                          )),
                                      Positioned(
                                        bottom: 25,
                                        right: 15,
                                        child: Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: KGreenColor,
                                              border: Border.all(
                                                  color: KPrimaryColor,
                                                  width: 2)),
                                          child: Center(
                                              child: Image.asset(
                                            "assets/+ (1).png",
                                            height: 10,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Stack(
                                  children: [
                                    Container(
                                      height: 147,
                                      width: 147,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: KWhiteLightColor),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: controller.pickedImage == null
                                            ? CachedNetworkImage(
                                                imageUrl: controller
                                                    .currentUser == null ? controller.auth!.photoURL.toString() : controller
                                                    .currentUser!.imgUrl == '' ? controller.auth!.photoURL.toString() : controller.currentUser!.imgUrl ,
                                                errorWidget: (context, error, imageUrl) => const Icon(Icons.error),
                                                    )
                                            : Image.file(
                                                controller.pickedImage!,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 25,
                                      right: 15,
                                      child: Container(
                                        height: 33,
                                        width: 33,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: KGreenColor,
                                            border: Border.all(
                                                color: KPrimaryColor,
                                                width: 2)),
                                        child: Center(
                                            child: Image.asset(
                                          "assets/close_24px.png",
                                          height: 10,
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 57.h,
                  ),
                  Text(
                    "Healthcare Facility Name",
                    style: headingSmallGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                    readonly: false,
                    hidden: false,
                    controller: controller.healthFacility,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Type of Facility ",
                    style: headingSmallGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                    readonly: false,
                    hidden: false,
                    controller: controller.typeFacility,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Email Address",
                    style: headingSmallGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                    readonly: true,
                    hidden: false,
                    controller: controller.email,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Address",
                    style: headingSmallGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                    readonly: false,
                    hidden: false,
                    controller: controller.addressinp,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Phone Contact",
                    style: headingSmallGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                    readonly: false,
                    hidden: false,
                    controller: controller.phoneContact,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Human Resources(HR) or Staffing Coordinator Contact",
                    style: headingSmallGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                    readonly: false,
                    hidden: false,
                    controller: controller.hrContact,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Button(
                    width: Get.width,
                    value: () {
                      controller.isUpdating ? null : controller.updateProfile();
                    },
                    txt: controller.isUpdating ? 'Updating...' : "Save",
                    txtColor: KPrimaryColor,
                    clr: controller.isUpdating ? KYellowColor : KSecondaryColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ))));
}
