// coverage:ignore-file
import 'dart:ffi';

import 'package:get/get.dart';
import 'app_pages.dart';

/// Contains the abstract class for the methods to go to a
/// particular screen across the whole App.
///
/// [RouteManagement] : Contains all such methods
///

abstract class RouteManagement {
  
  /// go to splash screen
  static void goToSplash() {
    Get.toNamed<void>(
      Routes.splash,
    );
  }

  static void goToStarted(){
    Get.offAllNamed<void>(
      Routes.started
    );
  }

  static void goToLogin() {
    Get.toNamed<void>(
      Routes.login,
    );
  }
  
  static void goToRegister() {
    Get.toNamed<void>(
      Routes.register,
    );
  }
  static void goToHome() {
    Get.offAllNamed<void>(
      Routes.home
    );
  }
  
  static void goToBooking(String argument){
    Get.offAllNamed<void>(
      Routes.booking, arguments: argument
    );
  }

  static dynamic goToPaypal() async{
    final result = await Get.toNamed<void>(
      Routes.paypal,
    );
    return result;
  }
  }
