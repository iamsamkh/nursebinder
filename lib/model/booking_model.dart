import 'package:cloud_firestore/cloud_firestore.dart';

class Booking{
  final String bookingId;
  final String facilityId;
  final Timestamp bookingDate;
  final Timestamp appointmentTime;
  final String nurseId;
  final String bookingStatus;
  final String orderStatus;
  final int hours;
  final String paymentMethod;
  final double totalAmount;
  final double additionalFee;
  final String bookingAddress;
  
  Booking(
    {
    required this.bookingId,
    required this.facilityId,
    required this.bookingDate,
    required this.appointmentTime,
    required this.nurseId,
    required this.bookingStatus,
    required this.orderStatus,
    required this.hours,
    required this.paymentMethod,
    required this.totalAmount,
    required this.additionalFee,
    required this.bookingAddress,
  }
    
  );

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId, 
      'facilityId': facilityId,
      'bookingDate': bookingDate,
      'appointmentTime': appointmentTime,
      'nurseId': nurseId,
      'bookingStatus': bookingStatus,
      'orderStatus': orderStatus,
      'hoursBooked': hours,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'additionalFee': additionalFee,
      'bookingAddress': bookingAddress,
    };
  }

  factory Booking.fromFirestore(DocumentSnapshot snapshot){
    return Booking(
      bookingId: snapshot['bookingId'],
      facilityId: snapshot['facilityId'],
      bookingDate: snapshot['bookingDate'],
      appointmentTime: snapshot['appointmentTime'],
      nurseId: snapshot['nurseId'],
      bookingStatus: snapshot['bookingStatus'],
      orderStatus: snapshot['orderStatus'],
      hours: snapshot['hoursBooked'],
      paymentMethod: snapshot['paymentMethod'],
      bookingAddress: snapshot['bookingAddress'],
      totalAmount: snapshot['totalAmount'],
      additionalFee: snapshot['additionalFee'],
    );
  }

  factory Booking.dumyBooking(){
    return Booking(
      bookingId: '',
      facilityId: '',
      bookingDate: Timestamp.now(),
      appointmentTime: Timestamp.now(),
      nurseId: '',
      bookingStatus: '',
      orderStatus: '',
      hours: 0,
      paymentMethod: '',
      bookingAddress: '',
      totalAmount: 0.0,
      additionalFee: 0.0,
    );
  }
}
