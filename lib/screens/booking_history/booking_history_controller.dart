import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/model/booking_model.dart';
import 'package:nurse_binder/model/review_model.dart';

import '../../constant.dart';
import '../../model/nurse_model.dart';

class BookingHistoryController extends GetxController {
  final _auth = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  ScrollController scrollController = ScrollController();

  //Booking History
  Rx<List<Booking>> bookingsData = Rx<List<Booking>>([]);
  List<Booking> get bookings => bookingsData.value;
  Rx<Map<String, Nurse>> nursesData = Rx<Map<String, Nurse>>({});
  Map<String, Nurse> get nurses => nursesData.value;
  Rx<bool> isLoading = false.obs;
  DocumentSnapshot? lastDoc;
  //Rating
  TextEditingController feedback = TextEditingController();
  Rx<List<dynamic>> improvementsList =
      Rx<List<dynamic>>([]);
  List<dynamic> get getImporvements => improvementsList.value;
  double ratings = 1;
  bool isReviewed = false;
  String tipAmount = '0';
  TextEditingController customTipController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListener);
    await fetchBookingHistory();
    isLoading.value = false;
  }

  Future<void> fetchBookingHistory() async {
    bookingsData.value.clear();
    try{
      await _firestore
        .collection('bookings')
        .orderBy('bookingDate')
        .limit(10)
        .get()
        .then((value) async {
      for (var snapB in value.docs) {
        lastDoc = snapB;
        Booking newBooking = Booking.fromFirestore(snapB);
        bookingsData.value.add(newBooking);
        if (!nursesData.value.containsKey(newBooking.nurseId)) {
          final snapN = await _firestore
              .collection('nurses')
              .doc(newBooking.nurseId)
              .get();
          Nurse newNurse = Nurse.fromFirestore(snapN);
          final newEntry = <String, Nurse>{newBooking.nurseId: newNurse};
          nursesData.value.addEntries(newEntry.entries);
        }
      }
    });
    }catch(_){

    }
  }

  Future<void> fetchLaterHistory() async {
    try{
      await _firestore
        .collection('bookings')
        .orderBy('bookingDate')
        .startAfterDocument(lastDoc!)
        .limit(10)
        .get()
        .then((value) async {
      for (var snapB in value.docs) {
        lastDoc = snapB;
        Booking newBooking = Booking.fromFirestore(snapB);
        bookingsData.value.add(newBooking);
        if (!nursesData.value.containsKey(newBooking.nurseId)) {
          final snapN = await _firestore
              .collection('nurses')
              .doc(newBooking.nurseId)
              .get();
          Nurse newNurse = Nurse.fromFirestore(snapN);
          final newEntry = <String, Nurse>{newBooking.nurseId: newNurse};
          nursesData.value.addEntries(newEntry.entries);
        }
      }
    });
    }catch(_){
      Get.showSnackbar(
          const GetSnackBar(
            message: 'Ops! Unable to load bookings',
            backgroundColor: KOrragneColor,
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
    }
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      await fetchLaterHistory();
      update();
    }
  }

  Future<void> submitReview(String nurseId, String bookingId) async{
    try{
      Review newReview = Review(facilityId: _auth!.uid, rating: ratings, comment: feedback.text, improvements: getImporvements, reviewTime: Timestamp.now());
    await _firestore.collection('nurses').doc(nurseId).collection('review').doc(bookingId).set(
      newReview.toMap()
    );
    final docSnap = await _firestore.collection('nurses').doc(nurseId).get();
    var newRating;
    Nurse nurse = Nurse.fromFirestore(docSnap);
    if(nurse.rating['totalCount'] != 0){
      newRating = (nurse.rating['avgrating'] + newReview.rating) / 2;
    }else{
      newRating = newReview.rating;
    }
    await _firestore.collection('nurses').doc(nurseId).update({'rating': {'avgrating': newRating, 'totalCount': nurse.rating['totalCount'] + 1}});
    }catch(e){
      print(e);
      rethrow;
    }
  }

  Future<dynamic> fetchReview(String nurseId, String bookingId) async {
    final _snap = await _firestore
        .collection('nurses')
        .doc(nurseId)
        .collection('review')
        .doc(bookingId)
        .get();
    if (_snap.exists) {
      Review review = Review.fromFirestore(_snap);
      improvementsList = Rx<List<dynamic>>(review.improvements);
      ratings = review.rating;
      feedback.value = TextEditingValue(text: review.comment);
      isReviewed = true;
      
    } else {
      improvementsList = Rx<List<Map<String, bool>>>([
        {'Overall Service': false},
        {'Communication': false},
        {'Behaviour': false},
        {'Service Quality': false},
        {'Timing': false},
        {'Tranparency': false}
      ]);
      ratings = 1;
      isReviewed = false;
      feedback.clear();
    }
  }
  
}
