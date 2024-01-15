import 'package:flutter/material.dart';
import 'package:mobile/constants/tags.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';
import 'package:mobile/widget/text_widgets.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final userID = AppPrefHelper.getUserID();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (userID != '') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.dashboard,
            (_) => false,
          );
        } else {
          Navigator.pushNamed(context, MyRoutes.authScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: HeroTags.fullTextLogo,
          child: ShiningText(
            text: 'Udhar Kab Dega',
            textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
