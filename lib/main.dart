import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import './constant.dart';
import './navigators/navigators.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_live_d9t4pBNyto608cqCPYVVp4fU00OeYneZCr'; // to be changed
  Stripe.merchantIdentifier = 'Nurse Binder';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'Nurse Binder',
          theme: ThemeData(
              scaffoldBackgroundColor: KPrimaryColor,
              splashColor: KPrimaryColor,
              fontFamily: 'Roboto',
              primarySwatch: Colors.blue,
              accentColor: KPrimaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              cardTheme: CardTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  elevation: 1),
              scrollbarTheme: const ScrollbarThemeData().copyWith(
                // interactive: true,
                isAlwaysShown: true,
                radius: const Radius.circular(10.0),
                thumbColor: MaterialStateProperty.all(Colors.black),
                thickness: MaterialStateProperty.all(5.0),
                minThumbLength: 50,
              )),
          getPages: AppPages.pages,
          enableLog: true,
          // home: BookingHistory(),
          initialRoute: Routes.splash,
          // initialBinding: SplashBinding(),
          unknownRoute: AppPages.pages[0],
         ),
      designSize: const Size(428, 926),
    );
  }
}
