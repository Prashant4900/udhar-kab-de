import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/constants/tags.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/clippers/login_clipper.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';

class MyLoginScreen extends StatelessWidget {
  const MyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.accountStatus == AccountStatus.accountVerified) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MyRoutes.dashboard,
              (route) => false,
            );
          }
          if (state.accountStatus == AccountStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong!. ${state.message}'),
              ),
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          return SizedBox.expand(
            child: Column(
              children: [
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: double.infinity,
                    color: context.colorScheme.primary,
                    child: Padding(
                      padding: horizontalPadding16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 2),
                          Hero(
                            tag: HeroTags.fullTextLogo,
                            child: Text(
                              'Udhar Kab Dega',
                              style: context.textTheme.headlineLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'मेरा पैसा मुझे वापस दे!!!',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: Colors.white)
                                .copyWith(fontStyle: FontStyle.italic),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 6),
                Padding(
                  padding: horizontalPadding16,
                  child: AuthButton(
                    icon: Icon(
                      Icons.phone,
                      color: context.colorScheme.onPrimary,
                    ),
                    label: 'Continue with phone',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MyRoutes.phoneAuthScreen,
                      );
                    },
                  ),
                ),
                verticalMargin16,
                if (state.accountStatus == AccountStatus.loading)
                  const CircularProgressIndicator.adaptive()
                else
                  Padding(
                    padding: horizontalPadding16,
                    child: AuthButton(
                      label: 'Sign in With Google',
                      icon: Assets.svg.googleIcon.svg(
                        width: kToolbarHeight / 2.2,
                      ),
                      backgroundColor: Colors.black,
                      onTap: () async {
                        try {
                          context.read<AuthBloc>().add(SignInWithGoogleEvent());
                        } catch (e) {
                          log('object $e');
                        }
                      },
                    ),
                  ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Terms',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 15,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Privacy Policy',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 15,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                verticalMargin48,
              ],
            ),
          );
        },
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.label,
    this.onTap,
    this.icon,
    this.backgroundColor,
    super.key,
  });

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: kToolbarHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onTap == null
              ? Colors.grey
              : backgroundColor ?? context.colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              horizontalMargin12,
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
