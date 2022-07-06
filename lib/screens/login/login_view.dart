import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/screens/screens.dart';
import '../../navigators/navigators.dart';
import 'package:nurse_binder/widget/button_widget.dart';

import '../../../constant.dart';
import '../../../widget/input_field_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (_controller) => SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          "assets/Nurse Binder Name.png",
                          width: Get.width * 0.6,
                        ),
                      ],
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
                      readonly: false,
                      hidden: false,
                      controller: _controller.email,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Password",
                      style: headingSmallGrey,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InputField(
                      readonly: false,
                      hidden: true,
                      controller: _controller.password,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Text(
                      "Forgot My Password",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: KGreyColor,
                          decoration: TextDecoration.underline,
                          fontFamily: "Roboto"),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    _controller.isLoading ? const Center(child: CircularProgressIndicator(),) :
                    Button(
                      clr: KSecondaryColor,
                      value: () {
                        _controller.tryLogin();
                      },
                      width: Get.width,
                      txt: "Sign In",
                      txtColor: KPrimaryColor,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: Get.width * 0.23,
                              child: const Divider(
                                thickness: 2,
                                color: KWhiteLightColor,
                              )),
                          SizedBox(
                            width: Get.width * 0.33,
                            child: Text(
                              "or continue with",
                              style: whiteSimpleText,
                            ),
                          ),
                          SizedBox(
                              width: Get.width * 0.23,
                              child: const Divider(
                                thickness: 2,
                                color: KWhiteLightColor,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _controller.signInWithGoogle,
                          child: Container(
                            width: Get.width * 0.25,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: KGreyColor,
                              ),
                            ),
                            child: Image.asset(
                              "assets/google.png",
                              height: 23,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 17.w,
                        ),
                        GestureDetector(
                          onTap: _controller.signInWithFacebook,
                          child: Container(
                            width: Get.width * 0.25,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: KGreyColor,
                              ),
                            ),
                            child: Image.asset(
                              "assets/facebook.png",
                              height: 23,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 17.w,
                        ),
                        // if(Platform.isIOS)
                        GestureDetector(
                          onTap: _controller.signInWithApple,
                          child: Container(
                            width: Get.width * 0.25,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: KGreyColor,
                              ),
                            ),
                            child: Image.asset(
                              "assets/apple-logo.png",
                              height: 23,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                child: GestureDetector(
                  onTap: () {
                    RouteManagement.goToRegister();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    height: 65.h,
                    child: Column(
                      children: const [Text("Doesn’t have an account ? Sign Up")],
                    ),
                  ),
                ),
              ),
            )));
  }
}
