import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/constants/tags.dart';
import 'package:mobile/repositories/auth_repository.dart';
import 'package:mobile/routes/route_manager.dart';

class MyLoginScreen extends StatelessWidget {
  const MyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: allPadding16,
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                emptyWidget,
                Hero(
                  tag: HeroTags.fullTextLogo,
                  child: Text(
                    'Udhar Kab Dega',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                emptyWidget,
                emptyWidget,
                emptyWidget,
                Column(
                  children: [
                    AuthButton(
                      label: 'Sign in With Google',
                      onTap: () async {
                        try {
                          await AuthRepository().signInWithGoogle();
                        } catch (e) {
                          log('object $e');
                        }
                      },
                    ),
                    verticalMargin24,
                    AuthButton(
                      label: 'Sign in With Apple',
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          MyRoutes.dashboard,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.onTap,
    required this.label,
    super.key,
  });

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
