import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/repositories/hotspot_repository.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/date_time.dart';
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
                            radius: 30,
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
                                : const Icon(
                                    Icons.person,
                                    size: 32,
                                    color: Colors.black,
                                  ),
                          ),
                          horizontalMargin16,
                          SizedBox(
                            height: 65,
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
                      verticalMargin4,
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
              verticalMargin24,
              SingleRowTile(
                label: 'Your Profile',
                icon: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.grey,
                  size: 18,
                ),
                onTap: () async {
                  // await UserRepository().getUserData();
                  await HotspotRepository().getHotspots();
                  // await HotspotRepository().createHotspot(
                  //   const HotspotModel(
                  //     hotspotName: 'My Name',
                  //     hotspotLocation: 'My Location',
                  //     hotspotType: 'My type',
                  //   ),
                  // );
                  // log(data.toString());
                  // HotspotRepository().createHotspot(
                  //   HotspotModel(
                  //     hostpotName: 'ASDFG',
                  //     hotspotLocation: 'asdfgghhh',
                  //     hotspotType: 'qwerrt',
                  //     userDocID: '65a972b9e33eb41f8a61',
                  //   ),
                  // );
                },
              ),
              verticalMargin12,
              SingleRowTile(
                label: 'Hotspot Areas',
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey,
                  size: 18,
                ),
                onTap: () =>
                    Navigator.pushNamed(context, MyRoutes.hotspotsScreen),
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
