import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<SplashController>(
    builder: (controller) => SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/Nurse Binder Logo.png",
                    height: Get.height * 0.15,
                    width: Get.width * 0.3,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Image.asset(
                    "assets/Nurse Binder Name.png",
                    width: Get.width * 0.6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}