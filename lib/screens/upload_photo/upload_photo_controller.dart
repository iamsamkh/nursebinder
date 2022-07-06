import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant.dart';
import '../../model/facility_model.dart';

class UploadPhotoController extends GetxController{
  final auth = FirebaseAuth.instance.currentUser;
  final _fireStorage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Facility? currentUser;

  final _picker = ImagePicker();
  File? pickedImage;
  bool isUpdating = false;
  TextEditingController healthFacility = TextEditingController();
  TextEditingController typeFacility = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController addressinp = TextEditingController();
  TextEditingController phoneContact = TextEditingController();
  TextEditingController hrContact = TextEditingController();

  @override
  void onInit() async{
    super.onInit();
    await getFacilityInfo();
    update(['home_view', 'upload_photo']);
  }
  
  Future<void> getFacilityInfo() async {
    try {
      final _snap = await _firestore
          .collection('FacilityData')
          .doc(auth!.uid)
          .get();
          currentUser = Facility.fromFirestore(_snap);
    } catch (e) {
      //catch implementation
    }
  }

  Future getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      update(['profile', 'upload_photo']);
    }
  }

  Future<String?> uploadImage()async{
    String? uploadUrl;
    if (pickedImage != null) {
      final ref = _fireStorage.ref('facilityProfiles').child(auth!.uid);
      try {
        await ref.putFile(pickedImage!);
        uploadUrl = await ref.getDownloadURL();
      } catch (_) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Ops! Image upload failed. Pleae try again....',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
    return uploadUrl;
  }


  Future<void> updateImgUrl() async{
    isUpdating = true;
    update(['upload_photo']);
    String? newImgUrl = await uploadImage();
    if(newImgUrl != null){
       try {
      await _firestore.collection('FacilityData').doc(auth!.uid).update({
        'imgUrl': newImgUrl
      });
    } catch (_) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Ops! Error occured. Please try again...',
          backgroundColor: KOrragneColor,
          isDismissible: true,
          duration: Duration(seconds: 2),
        ),
      );
      isUpdating = false;
    update(['upload_photo']);
      return;
    }
    }
    pickedImage = null;
    isUpdating = false;
    await getFacilityInfo();
    update(['upload_photo', 'home_view']);
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Profile Updated',
        backgroundColor: KGreenColor,
        isDismissible: true,
        duration: Duration(seconds: 2),
      ),
    );
  }


  Future<void> updateProfile() async {
    if (healthFacility.text.trim() == '' ||
        typeFacility.text.trim() == '' ||
        addressinp.text.trim() == '') {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Please check if all the fields are filled',
          backgroundColor: KOrragneColor,
          isDismissible: true,
          duration: Duration(seconds: 2),
        ),
      );
      isUpdating = false;
      update(['profile']);
      return;
    }

    if (int.tryParse(phoneContact.text.trim()) == null ||
        int.tryParse(hrContact.text.trim()) == null) {
      Get.showSnackbar(
        const GetSnackBar(
          message:
              'Phone Contact/ Staff Contact is either empty or is not a number',
          backgroundColor: KOrragneColor,
          isDismissible: true,
          duration: Duration(seconds: 2),
        ),
      );
      isUpdating = false;
      update(['profile']);
      return;
    }
    isUpdating = true;
    update(['profile']);
    String? uploadUrl;
    uploadUrl = await uploadImage();
    try {
      // final _snap = await _firestore.collection('FacilityData').doc(auth!.uid).get();
      // if(_snap.exists){

      // }
      await _firestore.collection('FacilityData').doc(auth!.uid).update({
        'facilityName': healthFacility.text,
        'facilityType': typeFacility.text,
        'facilityAddress': addressinp.text,
        'hrContact': int.tryParse(hrContact.text),
        'phoneContact': int.tryParse(phoneContact.text),
        'imgUrl': uploadUrl ?? currentUser?.imgUrl ?? ''
      });
    } on FirebaseException catch(e){
      if(e.code == 'not-found'){
        await _firestore.collection('FacilityData').doc(auth!.uid).set({
        'facilityId': auth!.uid,
        'facilityName': healthFacility.text,
        'facilityType': typeFacility.text,
        'email': auth!.email,
        'facilityAddress': addressinp.text,
        'hrContact': int.tryParse(hrContact.text),
        'phoneContact': int.tryParse(phoneContact.text),
        'imgUrl': uploadUrl ?? currentUser?.imgUrl ?? auth!.photoURL,
      });
      // auth!.updateDisplayName(healthFacility.text);
      }
    } catch (_) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Ops! Error occured. Please try again...',
          backgroundColor: KOrragneColor,
          isDismissible: true,
          duration: Duration(seconds: 2),
        ),
      );
      isUpdating = false;
      update(['profile']);
      return;
    }

    await getFacilityInfo();
    pickedImage = null;
    isUpdating = false;
    // update(['profile']);
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Profile Updated',
        backgroundColor: KGreenColor,
        isDismissible: true,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void setControllerValues() {
    healthFacility.value = TextEditingValue(text: currentUser?.fName ?? auth!.displayName.toString());
    typeFacility.value = TextEditingValue(text: currentUser?.fType ?? '');
    email.value = TextEditingValue(text: currentUser?.fEmail ?? auth!.email.toString());
    addressinp.value = TextEditingValue(text: currentUser?.fAddress ?? '');
    phoneContact.value =
        TextEditingValue(text: currentUser?.phoneContact.toString() ?? '');
    hrContact.value = TextEditingValue(text: currentUser?.hrContact.toString() ?? '');
  }
}