import 'package:get/get.dart';
import '../screens.dart';

/// A list of bindings which will be used in the route of [UploadPhotoView].
class UploadPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      UploadPhotoController(),
    );
  }
}
