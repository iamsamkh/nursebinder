import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nurse_binder/model/nurse_model.dart';
import 'package:nurse_binder/model/review_model.dart';
import 'package:nurse_binder/screens/booking_history/booking_history.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../../model/booking_model.dart';
import '../../model/facility_model.dart';
import '../../navigators/routes_management.dart';
import '../screens.dart';

class HomeController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  final _geo = Geoflutterfire();
  //navbar
  Rx<int> currentindex = 0.obs;
  List iconList = [
    const HomeView(),
    const BookingHistory(),
  ];
  //location
  var latitude = 'Getting Latitude..'.obs;
  var longitude = 'Getting Longitude..'.obs;
  var address = 'Getting Address..'.obs;
  //Find Nurse
  Rx<List<Nurse>> nurseList = Rx<List<Nurse>>([]);
  List<Nurse> get nurseData => nurseList.value;
  int currentNurseSelection = -1;
  //NurseInfoDetail
  ScrollController scrollController = ScrollController();
  DateTime _serverTime = DateTime.now();
  DateTime get getServerTime => _serverTime;
  int timeSelection = -1;
  int dateSelection = -1;
  int hourCountSelection = 0;
  Rx<List<Review>> reviewData = Rx<List<Review>>([]);
  List<Review> get nurseReviews => reviewData.value;
  Rx<Map<String, Facility>> facilityList = Rx<Map<String, Facility>>({});
  Map<String, Facility> get getFacilityData => facilityList.value;
  bool hasReviews = true;
  //payment
  String paymentType = 'Card Payment';
  double additionalFee = 0;
  //upcomingbooking
  Rx<List<Map<String, dynamic>>> upComingBook =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get upBooking => upComingBook.value;
  bool isempty = false;

  @override
  void onInit() async {
    super.onInit();
    await determinePosition();
    nurseList.bindStream(nurseStream());
    isempty = await fetchUpcomingBookings();
    update(['upComingBooking']);
  }

  @override
  void onClose() {
    nurseList.close();
    super.onClose();
  }

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    await Geolocator.getCurrentPosition().then((Position position) async {
      latitude.value = '${position.latitude}';
      longitude.value = '${position.longitude}';
      await getAddressFromLatLang(position);
    });
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address.value =
        '${place.street},${place.locality},${place.country},${place.postalCode}';
  }

  nurseStream() {
    try {
      final double lat = double.parse(latitude.value);
      final double lng = double.parse(longitude.value);
      GeoFirePoint center = _geo.point(latitude: lat, longitude: lng);
      var collectionReference = _firestore.collection('nurses');

      double radius = 1000;
      return _geo
          .collection(collectionRef: collectionReference)
          .within(center: center, radius: radius, field: 'position')
          .map((event) {
        List<Nurse> retVal = List.empty(growable: true);
        event.forEach((element) {
          retVal.add(Nurse.fromFirestore(element));
        });
        retVal.sort(mySortComparison);
        return retVal;
      });
    } catch (e) {
      print('No Lat/Lng');
    }
  }

  int mySortComparison(Nurse a, Nurse b) {
    final propertyA = a.rating['avgrating'];
    final propertyB = b.rating['avgrating'];
    if (propertyA < propertyB) {
      return 1;
    } else if (propertyA > propertyB) {
      return -1;
    } else {
      return 0;
    }
  }

  Future<void> fetchServerTime() async {
    try {
      await _firestore
          .collection('timestamp')
          .doc(auth!.uid)
          .set({'time': FieldValue.serverTimestamp()});
      DocumentSnapshot doc =
          await _firestore.collection('timestamp').doc(auth!.uid).get();
      Timestamp timestamp = doc['time'];
      _serverTime = timestamp.toDate();
    } catch (_) {
      _serverTime = DateTime.now();
    }
  }

  Future<void> fetchNurseReviews(String nurseId) async {
    reviewData.value.clear();
    hasReviews = true;
    try {
      await _firestore
          .collection('nurses')
          .doc(nurseId)
          .collection('review')
          .orderBy('reviewTime')
          .limit(5)
          .get()
          .then((value) async {
        for (var snap in value.docs) {
          Review newReview = Review.fromFirestore(snap);
          reviewData.value.add(newReview);
          if (!facilityList.value.containsKey(newReview.facilityId)) {
            final snapF = await _firestore
                .collection('FacilityData')
                .doc(newReview.facilityId)
                .get();
            Facility newFacility = Facility.fromFirestore(snapF);
            final newEntry = <String, Facility>{
              newReview.facilityId: newFacility
            };
            facilityList.value.addEntries(newEntry.entries);
          }
        }
        hasReviews = false;
        update(['nurseInfoDetail']);
      });
    } catch (_) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Ops! Unable to load review',
          backgroundColor: KOrragneColor,
          isDismissible: true,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void resetNurseInfoDetail() {
    reviewData.value.clear();
    scrollController = ScrollController();
    timeSelection = -1;
    dateSelection = -1;
    hourCountSelection = 0;
  }

  Timestamp get generateBookingDate => Timestamp.fromDate(DateTime(
      _serverTime.year, _serverTime.month, dateSelection, timeSelection));

  double generateTotal() {
    double total =
        nurseData[currentNurseSelection].hourlyRate * hourCountSelection +
            additionalFee;
    return total;
  }

  Future<String> trybooking() async {
    final ref = _firestore.collection('bookings');
    var docId = ref.doc();
    Booking newBooking = Booking(
        facilityId: auth!.uid,
        bookingId: docId.id,
        bookingDate: Timestamp.now(),
        appointmentTime: generateBookingDate,
        nurseId: nurseData[currentNurseSelection].nurseId,
        bookingStatus: 'Pending',
        orderStatus: 'Active',
        hours: hourCountSelection,
        paymentMethod: paymentType,
        totalAmount: generateTotal(),
        additionalFee: additionalFee,
        bookingAddress: address.value);
    await ref.doc(docId.id).set(newBooking.toMap());
    return docId.id;
  }

  Future<bool> fetchUpcomingBookings() async {
    upComingBook.value.clear();
    await _firestore
        .collection('bookings')
        .where('appointmentTime', isGreaterThan: Timestamp.now())
        .where('orderStatus', isEqualTo: 'Active')
        .where('facilityId', isEqualTo: auth!.uid)
        .limit(5)
        .get()
        .then((value) async {
      for (var snap in value.docs) {
        Booking booking = Booking.fromFirestore(snap);
        final _snap =
            await _firestore.collection('nurses').doc(booking.nurseId).get();
        Nurse nurse = Nurse.fromFirestore(_snap);
        upComingBook.value.add({
          'nurseTitle': nurse.nurseTitle,
          'nurseType': nurse.nurseType,
          'nurseImgUrl': nurse.imgUrl,
          'appointmentTime': booking.appointmentTime
        });
      }
    });
    return true;
  }

  Future<void> makePayment() async {
    String total = '${generateTotal()*100}';
    print(total);
    final url = Uri.parse(
        'https://us-central1-nursebinder.cloudfunctions.net/stripePaymentIntent');
    Map<String, dynamic> body = {
      'amount': total,
      'currency': 'USD',
    };
    try {
      final response = await http.post(url, body: body);
      var jsonResponse = jsonDecode(response.body);
      Map<String, dynamic> paymentIntentData = jsonResponse;
      if (paymentIntentData['paymentIntent'] != '' &&
          paymentIntentData['paymentIntent'] != null) {
        String _intent = paymentIntentData['paymentIntent'];
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: _intent,
            applePay: true,
            googlePay: true,
            style: ThemeMode.system,
            merchantCountryCode: 'US',
            merchantDisplayName: 'Nurse Binder',
            testEnv: false,
          ),
        );
        await Stripe.instance.presentPaymentSheet();
        paymentIntentData.clear();
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Payment Successful',
            isDismissible: true,
            duration: Duration(seconds: 2),
          ),
        );
        final bookingId = await Get.showOverlay(
            asyncFunction: trybooking,
            loadingWidget: const Center(
              child: CircularProgressIndicator(),
            ));
        RouteManagement.goToBooking(bookingId);
      }
    } on StripeException catch (_) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Payment Unsuccesful',
          isDismissible: true,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (_) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Payment Unsuccesful',
          isDismissible: true,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
