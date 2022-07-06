import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nurse_binder/constant.dart';

/// A controller for [SignUpView] to update the UI.
class RegisterController extends GetxController {
  TextEditingController healthFacility = TextEditingController();
  TextEditingController typeFacility = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneContact = TextEditingController();
  TextEditingController humanResource = TextEditingController();

  bool isAgreeTerms = false;
  bool isAgreePolicy = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  void validateAndRegister() async {
    // isLoading = !isLoading;
    // update();
    if (healthFacility.text.trim() == '' ||
        typeFacility.text.trim() == '' ||
        address.text.trim() == ''
        ) {
      Get.showSnackbar(
          const GetSnackBar(
            message: 'Please check if all the fields are filled',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }
    if( password.text.trim().length < 6) {
      Get.showSnackbar(
          const GetSnackBar(
            message: 'Password length must be greater than 6',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }
    if(!validateEmail(email.text.trim())){
      Get.showSnackbar(
          const GetSnackBar(
            message: 'Missing or invalid email format',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }
    if(int.tryParse(phoneContact.text.trim()) == null ||
      int.tryParse(humanResource.text.trim()) == null
      ) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Phone Contact/ Staff Contact is either empty or is not a number',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
      return;
      }
    if(!isAgreePolicy || !isAgreeTerms){
      Get.showSnackbar(
          const GetSnackBar(
            message: 'Please read and accept our Terms and Conditions/Privacy Policy before moving furthur',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }
      isLoading = true;
      update();
      UserCredential authResult;
      try {
        authResult = await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
        FirebaseFirestore.instance
              .collection('FacilityData')
              .doc(authResult.user!.uid)
              .set({
            'facilityId': authResult.user!.uid,
            'facilityName': healthFacility.text.trim(),
            'facilityType': typeFacility.text.trim(),
            'email': authResult.user!.email.toString(),
            'facilityAddress': address.text.trim(),
            'phoneContact': int.tryParse(phoneContact.text),
            'hrContact': int.tryParse(humanResource.text),
            'imgUrl': '',
            'joiningDate': Timestamp.fromDate(DateTime.now()),
          });
      } on FirebaseException catch(e){
        if(e.code == 'invalid-email'){
          Get.showSnackbar(
          const GetSnackBar(
            message: 'Missing or invalid email format',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
        } else{
          Get.showSnackbar(
          const GetSnackBar(
            message: 'Ops! Server Error. Please try again...',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
        }
      } 
      catch (e) {
        isLoading = false;
        update();
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Ops! Error occured. Please try again...',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
      }
      isLoading = false;
      update();
  }
  
  bool validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value)) {
      return false;
    }
    else{
      return true;
    }
  }
}
