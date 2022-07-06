// coverage:ignore-file
part of 'app_pages.dart';

/// A chunks of routes and the path names which will be used to create
/// routes in [AppPages].
abstract class Routes {
  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const home = _Paths.home;
  static const started = _Paths.started;
  static const booking = _Paths.booking;
  static const paypal = _Paths.paypal;
}

abstract class _Paths {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const started = '/started';
  static const booking = '/booking';
  static const paypal ='/paypal';
}
