// coverage:ignore-file
import 'package:get/get.dart';
import 'package:nurse_binder/screens/home/pages/bottom_bar.dart';
import '../screens/screens.dart';
part 'app_routes.dart';

/// Contains the list of pages or routes taken across the whole application.
/// This will prevent us in using context for navigation. And also providing
/// the blocs required in the next named routes.
///
/// [pages] : will contain all the pages in the application as a route
/// and will be used in the material app.
/// Will be ignored for test since all are static values and would not change.
class AppPages {
  static var transitionDuration = const Duration(
    milliseconds: 350,
  );
  static const initial = Routes.splash;

  static final pages = [
    GetPage<SplashView>(
      name: _Paths.splash,
      transitionDuration: transitionDuration,
      page: SplashView.new,
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<GetStarted>(
      name: _Paths.started,
      page: GetStarted.new,
      transitionDuration: transitionDuration,
      transition: Transition.fadeIn,
    ),
    GetPage<LoginView>(
      name: _Paths.login,
      transitionDuration: transitionDuration,
      page: LoginView.new,
      binding: LoginBinding(),
      transition: Transition.downToUp,
    ),
    GetPage<RegisterView>(
      name: _Paths.register,
      transitionDuration: transitionDuration,
      page: RegisterView.new,
      binding: RegisterBinding(),
      transition: Transition.downToUp,
    ),
    GetPage<HomeView>(
      name: _Paths.home,
      transitionDuration: transitionDuration,
      page: BottomBar.new,
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<BookingView>(
      name: _Paths.booking,
      transitionDuration: transitionDuration,
      page: BookingView.new,
      binding: BookingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<PaypalView>(
        name: _Paths.paypal,
        page: PaypalView.new,
        binding: PaypalBinding(),
        transition: Transition.fadeIn),
  ];
}
