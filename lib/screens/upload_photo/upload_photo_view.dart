import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/constant.dart';
import 'package:nurse_binder/navigators/navigators.dart';
import 'package:nurse_binder/screens/screens.dart';

import '../../widget/button_widget.dart';

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<UploadPhotoController>(
    id: 'upload_photo',
    builder: (controller) => SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          child: controller.pickedImage == null
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
                                        child: Image.file(
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
                height: 20.h,
              ),
              Text(
                controller.currentUser == null &&
                            controller.auth!.displayName == null
                        ? 'loading...'
                        : controller.currentUser == null
                            ? controller.auth!.displayName.toString()
                            : controller.currentUser!.fName,
                style: headingText,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                controller.currentUser == null &&
                            controller.auth!.displayName == null
                        ? 'loading...'
                        : controller.currentUser == null
                            ? ''
                            : controller.currentUser!.fType,
                style: headingSmallGrey,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 85.h,
              ),
              controller.isUpdating ? const Center(child: CircularProgressIndicator(),) : Button(
                width: Get.width,
                clr: controller.pickedImage == null ? KWhiteLightColor : KSecondaryColor,
                txtColor: controller.pickedImage == null ? KGreyLightColor : KPrimaryColor,
                txt: "Upload Photo",
                value: () async{
                  if(controller.pickedImage != null){
                     await controller.updateImgUrl();
                  // Get.back(closeOverlays: true);
                  RouteManagement.goToHome();
                  }
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {

                  RouteManagement.goToHome();
                },
                child: Text(
                  "Skip for this",
                  style: underlineText,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ));
}
