import 'package:get/get.dart';
import 'package:nurse_binder/screens/booking_history/booking_history_controller.dart';
import '../screens.dart';

/// A list of bindings which will be used in the route of [HomeView].
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UploadPhotoController());
    Get.put(HomeController());
    Get.lazyPut(() => BookingHistoryController());
  }
}
