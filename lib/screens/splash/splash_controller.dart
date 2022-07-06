import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nurse_binder/screens/screens.dart';

import '../../navigators/navigators.dart';
// import '../../navigators/navigators.dart';

/// A controller for [SplashView] to update the UI.
class SplashController extends GetxController {

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  User? get currentUser => _user.value;

  _initialScreen(User? user) async{
    if (user == null) {
      Future.delayed (
        const Duration(
        seconds: 2,
        ),
        RouteManagement.goToStarted
    );
    } else {
      if(Get.currentRoute == '/register'){
        Get.to(() => const UploadPhoto(), binding: UploadPhotoBinding());
      }else{
        RouteManagement.goToHome();
      }
    }
  }
 
}
