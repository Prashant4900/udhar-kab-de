import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/widget/feature_tile.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.accountStatus == AccountStatus.accountLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.authScreen,
            (route) => false,
          );
        }

        if (state.accountStatus == AccountStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something wrong!.')),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: allPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalMargin24,
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFF1F1F1),
                    child: (state.user?.name != null && state.user?.name != '')
                        ? Text(
                            state.user!.name.characters.first,
                            style: context.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Icon(Icons.person),
                  ),
                  horizontalMargin16,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.user?.name != ''
                            ? state.user!.name
                            : 'Guest User',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      verticalMargin4,
                      Text(
                        state.user?.email != ''
                            ? state.user!.email
                            : state.user?.phone != ''
                                ? state.user!.phone
                                : '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ],
              ),
              verticalMargin12,
              const Divider(),
              verticalMargin12,
              const FeatureTile(
                title: 'HotSpot Area',
                icon: Icons.store_mall_directory,
              ),
              const FeatureTile(
                title: 'Account',
                icon: Icons.person,
              ),
              verticalMargin12,
              Text(
                'Feedback',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalMargin12,
              const FeatureTile(
                title: 'Rate Us',
                icon: Icons.star,
              ),
              const FeatureTile(
                title: 'Contact Us',
                icon: Icons.message,
              ),
              const Divider(),
              FeatureTile(
                title: 'Log Out',
                icon: Icons.logout,
                color: context.colorScheme.error,
                onTap: () => context.read<AuthBloc>()..add(SignOutEvent()),
              ),
            ],
          ),
        );
      },
    );
  }
}
