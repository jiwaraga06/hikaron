import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikaron/source/pages/Auth/login.dart';
import 'package:hikaron/source/pages/Auth/splashScreen.dart';
import 'package:hikaron/source/pages/bottomNavBar.dart';
import 'package:hikaron/source/pages/dashboard/Home/DoRealitzation.dart';
import 'package:hikaron/source/pages/dashboard/Home/home.dart';
import 'package:hikaron/source/pages/dashboard/Home/stockOpname.dart';
import 'package:hikaron/source/pages/dashboard/notifikasi.dart';
import 'package:hikaron/source/pages/dashboard/profile.dart';
import 'package:hikaron/source/router/string.dart';

class RouterNavigation {
  static final pages = [
    GetPage(
      name: SPLASH,
      page: () => SplashScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: LOGIN,
      page: () => Login(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: BOTTOM_NAV,
      page: () => BottomNavbar(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: HOME,
      page: () => Home(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: STOCK_OPNAME,
      page: () => StockOpname(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: DO_REALIZATION,
      page: () => DoRealization(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: NOTIFIKASI,
      page: () => Notifikasi(),
      // transition: Transition.zoom,
    ),
    GetPage(
      name: PROFILE,
      page: () => Profile(),
      // transition: Transition.zoom,
    ),
  ];
  // Route? generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case SPLASH:
  //       return PageRouteBuilder(
  //           pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
  //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //             return SlideTransition(
  //               transformHitTests: false,
  //               position: Tween<Offset>(
  //                 begin: const Offset(-1.0, 0.0),
  //                 end: Offset.zero,
  //               ).animate(animation),
  //               child: SlideTransition(
  //                 position: Tween<Offset>(
  //                   begin: Offset.zero,
  //                   end: const Offset(1.0, 0.0),
  //                 ).animate(secondaryAnimation),
  //                 child: child,
  //               ),
  //             );
  //           });
  //     case LOGIN:
  //       return MaterialPageRoute(builder: (context) => Login());
  //     case BOTTOM_NAV:
  //       return PageRouteBuilder(
  //           pageBuilder: (context, animation, secondaryAnimation) => const BottomNavbar(),
  //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //             return SlideTransition(
  //               transformHitTests: false,
  //               position: Tween<Offset>(
  //                 begin: const Offset(1.0, 0.0),
  //                 end: Offset.zero,
  //               ).animate(animation),
  //               child: SlideTransition(
  //                 position: Tween<Offset>(
  //                   begin: Offset.zero,
  //                   end: const Offset(-1.0, 0.0),
  //                 ).animate(secondaryAnimation),
  //                 child: child,
  //               ),
  //             );
  //           });
  //     case HOME:
  //       return MaterialPageRoute(builder: (context) => Home());
  //     case STOCK_OPNAME:
  //       return PageRouteBuilder(
  //           pageBuilder: (context, animation, secondaryAnimation) => const StockOpname(),
  //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //             return SlideTransition(
  //               transformHitTests: false,
  //               position: Tween<Offset>(
  //                 begin: const Offset(1.0, 0.0),
  //                 end: Offset.zero,
  //               ).animate(animation),
  //               child: SlideTransition(
  //                 position: Tween<Offset>(
  //                   begin: Offset.zero,
  //                   end: const Offset(1.0, 0.0),
  //                 ).animate(secondaryAnimation),
  //                 child: child,
  //               ),
  //             );
  //           });
  //     case DO_REALIZATION:
  //       return PageRouteBuilder(
  //           pageBuilder: (context, animation, secondaryAnimation) => const DoRealization(),
  //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //             return SlideTransition(
  //               transformHitTests: false,
  //               position: Tween<Offset>(
  //                 begin: const Offset(1.0, 0.0),
  //                 end: Offset.zero,
  //               ).animate(animation),
  //               child: SlideTransition(
  //                 position: Tween<Offset>(
  //                   begin: Offset.zero,
  //                   end: const Offset(-1.0, 0.0),
  //                 ).animate(secondaryAnimation),
  //                 child: child,
  //               ),
  //             );
  //           });
  //     case NOTIFIKASI:
  //       return MaterialPageRoute(builder: (context) => Notifikasi());
  //     case PROFILE:
  //       return MaterialPageRoute(builder: (context) => Profile());

  //     default:
  //       return null;
  //   }
  // }
}
