import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/constant.dart';
import 'package:nurse_binder/navigators/navigators.dart';

import '../../widget/button_widget.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/Background (5).png",
            ),
            fit: BoxFit.cover,
          )),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset("assets/Nurse Binder Logo.png",
                        height: Get.height * 0.15)),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Find your best \nHealthcare \nprofessional here",
                      style: MainWhiteheading,
                    )),
                Column(
                  children: [
                    Button(
                      width: Get.width,
                      clr: KSecondaryColor,
                      value: () {
                        RouteManagement.goToRegister();
                      },
                      txt: "Get Started",
                      txtColor: KPrimaryColor,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Button(
                      width: Get.width,
                      clr: KPrimaryColor,
                      value: () {
                        RouteManagement.goToLogin();
                      },
                      txt: "Sign In",
                      txtColor: KBlackLightColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
