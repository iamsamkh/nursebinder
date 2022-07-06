import 'package:get/get.dart';
import '../screens.dart';

/// A list of bindings which will be used in the route of [BookingView].
class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut( 
      () => BookingController(),
    );
  }
}
