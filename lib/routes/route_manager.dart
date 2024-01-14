import 'package:flutter/material.dart';
import 'package:mobile/views/auth/login_screen.dart';
import 'package:mobile/views/dashboard/dashboard.dart';
import 'package:mobile/views/friends/add_friend_screen.dart';
import 'package:mobile/views/splash/splash_screen.dart';

part 'route_names.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const MyDashboard(),
        );
      case MyRoutes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const MySplashScreen(),
        );
      case MyRoutes.addFriendScreen:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MyAddFriendScreen(),
          transitionDuration: const Duration(
            // seconds: 1,
            milliseconds: 500,
          ), // Set your desired duration
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1, 1);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case MyRoutes.authScreen:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MyLoginScreen(),
          transitionDuration: const Duration(
            seconds: 1,
            // milliseconds: 500,
          ), // Set your desired duration
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1, 0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}