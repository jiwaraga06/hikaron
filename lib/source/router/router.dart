import 'package:flutter/material.dart';
import 'package:hikaron/source/pages/index.dart';
import 'package:hikaron/source/router/string.dart';

class RouterNavigation {
  SlideTransition bottomToTop(context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  SlideTransition topToBottom(context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  SlideTransition rightToLeft(context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  SlideTransition leftToRight(context, animation, secondaryAnimation, child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
          transitionsBuilder: bottomToTop,
        );
      case LOGIN:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Login(),
          transitionsBuilder: bottomToTop,
        );
      case BOTTOM_NAV:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const BottomNavbar(),
          transitionsBuilder: rightToLeft,
        );
      case HOME:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
          transitionsBuilder: rightToLeft,
        );
      case STOCK_OPNAME:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const StockOpname(),
          transitionsBuilder: leftToRight,
        );
      case DO_REALIZATION:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const DoRealization(),
          transitionsBuilder: rightToLeft,
        );
      case GOODS_RECEIPT:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const GoodsReceipt(),
          transitionsBuilder: leftToRight,
        );
      case RETURN:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ReturnScreem(),
          transitionsBuilder: rightToLeft,
        );
      case PUT_AWAY:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const PutAwayScreen(),
          transitionsBuilder: rightToLeft,
        );
      case NOTIFIKASI:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const Notifikasi());
      case PROFILE:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const Profile());

      default:
        return null;
    }
  }
}
