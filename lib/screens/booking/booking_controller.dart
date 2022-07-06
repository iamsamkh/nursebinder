import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/model/booking_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import '../../model/nurse_model.dart';

class BookingController extends GetxController{
  final _firestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
  
  String bookingId = '';
  Rx<Booking> bookingInfo =Rx<Booking>(Booking.dumyBooking());
  Nurse? nurseInfo = null;
  Rx<bool>isLoading = true.obs;

  TextEditingController textController = TextEditingController();
  Rx<bool> sendingText = false.obs;

  @override
  void onInit() async{
    super.onInit();
    bookingId = Get.arguments;
    bookingInfo
    .bindStream(fetchBookingInfo());

  }

  // Future<void> fetchBookingInfo() async{
  //   _firestore.collection('bookings').doc(bookingId).snapshots().listen((event) {
  //     bookingInfo = Booking.fromFirestore(event).obs;
  //     print(bookingInfo.value);
  //     if(nurseInfo == null){
  //       fetchNurseInfo(bookingInfo.value!.nurseId);
  //     }
  //   });
  Stream<Booking> fetchBookingInfo() {
    return _firestore.collection('bookings').doc(bookingId).snapshots().map((snapshot) {
      final data = Booking.fromFirestore(snapshot);
      if(nurseInfo == null) {
        fetchNurseInfo(data.nurseId);
      }
      return data;
    }
      );
  }

  Future<void> fetchNurseInfo(String nurseId) async{
    final snap = await _firestore.collection('nurses').doc(nurseId).get();
    nurseInfo = Nurse.fromFirestore(snap);
    isLoading.value = false;
    update();
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: nurseInfo!.contactNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendText() async{
    try{
        sendingText.value = true;
      _firestore.collection('bookings').doc(bookingId).collection('chat').add({'text': textController.value.text, 'time': Timestamp.now(), 'senderId': _currentUser});
      textController.clear();
      sendingText.value = false;
    }catch(_){
      sendingText.value = false;
      Get.showSnackbar(
          const GetSnackBar(
            message: 'Ops! Error occured while sending your text...',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
    }
  }
}