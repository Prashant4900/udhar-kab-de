import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/widget/feature_tile.dart';

String formatDate(String isoDate) {
  // Parse the ISO date time string
  final dateTime = DateTime.parse(isoDate);

  // Format the date time to month-year format
  final formattedDate = DateFormat.yMMMM().format(dateTime);

  return formattedDate;
}

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
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.images.background.path,
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: verticalPadding16 + horizontalPadding12,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: const Color(0xFFF1F1F1),
                            child: (state.user?.name != null &&
                                    state.user?.name != '')
                                ? Text(
                                    state.user!.name.characters.first,
                                    style: context.textTheme.headlineMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const Icon(Icons.person),
                          ),
                          horizontalMargin16,
                          SizedBox(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  (state.user?.name != null &&
                                          state.user?.name != '')
                                      ? state.user!.name
                                      : 'Guest User',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                // verticalMargin8,
                                Text(
                                  (state.user?.email != '' &&
                                          state.user?.email != null)
                                      ? state.user!.email
                                      : (state.user?.phone != '' &&
                                              state.user?.phone != null)
                                          ? state.user!.phone
                                          : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalMargin12,
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            'Joined At: '
                            '${formatDate(state.user!.registration)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalMargin12,
              const Divider(),
              verticalMargin12,
              FeatureTile(
                title: 'HotSpot Area',
                icon: Icons.store_mall_directory,
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.hotspotsScreen);
                },
              ),
              FeatureTile(
                title: 'Account',
                icon: Icons.person,
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.accountDetail);
                },
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
