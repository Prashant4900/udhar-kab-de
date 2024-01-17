import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/tags.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/widget/text_widgets.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>()..add(UserStatusEvent()),
      listener: (context, state) {
        final userID = AppPrefHelper.getUserID();
        if (state.userStatus == UserStatus.loggedOut && userID == '') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.authScreen,
            (_) => false,
          );
        }
        if (state.userStatus == UserStatus.loggedIn) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.dashboard,
            (_) => false,
          );
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
