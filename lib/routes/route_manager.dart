import 'package:flutter/material.dart';
import 'package:mobile/views/account/account_screen.dart';
import 'package:mobile/views/account/acount_detail_screen.dart';
import 'package:mobile/views/auth/add_details_screen.dart';
import 'package:mobile/views/auth/login_screen.dart';
import 'package:mobile/views/auth/otp_screen.dart';
import 'package:mobile/views/auth/phone_auth_screen.dart';
import 'package:mobile/views/dashboard/dashboard.dart';
import 'package:mobile/views/friends/add_friend_screen.dart';
import 'package:mobile/views/hotspots/add_hotspot_screen.dart';
import 'package:mobile/views/hotspots/hotspots_screen.dart';
import 'package:mobile/views/splash/splash_screen.dart';

part 'models.dart';
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

      case MyRoutes.addHotspotsScreen:
        return MaterialPageRoute(
          builder: (_) => const MyAddHotspotScreen(),
        );
      case MyRoutes.accountDetail:
        return MaterialPageRoute(
          builder: (_) => const MyAccountDetailScreen(),
        );
      case MyRoutes.hotspotsScreen:
        return MaterialPageRoute(
          builder: (_) => const MyHotSpotsScreen(),
        );
      case MyRoutes.phoneAuthScreen:
        return MaterialPageRoute(
          builder: (_) => const MyPhoneAuthScreen(),
        );
      case MyRoutes.addDetailsScreen:
        return MaterialPageRoute(builder: (_) => const MyAddDetailsScreen());
      case MyRoutes.otpScreen:
        final args = settings.arguments! as OTPScreenRouteArgs;

        return MaterialPageRoute(
          builder: (_) => MyOTPScreen(
            number: args.number,
          ),
        );
      case MyRoutes.addAccountScreen:
        return MaterialPageRoute(builder: (_) => const MyAccountScreen());

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
