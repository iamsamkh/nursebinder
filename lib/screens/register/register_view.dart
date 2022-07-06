import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/constant.dart';
import 'package:nurse_binder/navigators/navigators.dart';
import 'package:nurse_binder/screens/screens.dart';
import 'package:nurse_binder/widget/button_widget.dart';

import '../../../widget/input_field_widget.dart';
import '../login/login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (_controller) => SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView(
          children: [
            SizedBox(
              height: 65.h,
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
              "Healthcare Facility Name",
              style: headingSmallGrey,
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              readonly: false,
              hidden: false,
              controller: _controller.healthFacility,
              
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
              controller: _controller.typeFacility,
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
              controller: _controller.address,
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
              controller: _controller.phoneContact,
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
              controller: _controller.humanResource,
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {
                  _controller.isAgreeTerms = !_controller.isAgreeTerms;
                  _controller.update();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: _controller.isAgreeTerms ? KSecondaryColor : KWhiteLightColor,
                          width: 2),
                      color: _controller.isAgreeTerms ?  KSecondaryColor : KPrimaryColor,
                    ),
                    child: const Icon(Icons.check, size: 12, color: KPrimaryColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "I agree with the",
                          style: TextStyle(
                              color: KGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: " Term and Conditions",
                          style: TextStyle(
                            color: KSecondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () {
                  _controller.isAgreePolicy = !_controller.isAgreePolicy;
                  _controller.update();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: _controller.isAgreePolicy? KSecondaryColor : KWhiteLightColor,
                          width: 2),
                      color: _controller.isAgreePolicy ? KSecondaryColor : KPrimaryColor ,
                    ),
                    child: const Icon(Icons.check, size: 12, color: KPrimaryColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "I agree with Nurse Binder",
                          style: TextStyle(
                              color: KGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: " Privacy Policy",
                          style: TextStyle(
                            color: KSecondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            _controller.isLoading == true ? const Center(child: CircularProgressIndicator(),) :
            Button(
              txt: "Sign Up",
              width: Get.width,
              txtColor: KPrimaryColor,
              value: () {
                _controller.validateAndRegister();
              },
              clr: KSecondaryColor,
            ),
            SizedBox(
              height: 15.h,
            ),
            if(!_controller.isLoading)
            GestureDetector(
              onTap: () {
                RouteManagement.goToLogin();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?  Login",
                    style: headingSmallGrey,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    ))); 
  }
}