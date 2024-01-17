import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/account/feature_tile.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';

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
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Account',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: horizontalPadding12,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalMargin24,
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFFF1F1F1),
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.person),
                        ),
                      ),
                      horizontalMargin12,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Minesh Sarawogi',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          verticalMargin4,
                          Text(
                            'mineshsarawogi@gmail.com',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.edit,
                        color: Colors.black,
                      )
                    ],
                  ),
                  verticalMargin12,
                  const Divider(),
                  verticalMargin12,
                  const featureTile(
                    title: 'Hotspot Area',
                    icon: Icons.store_mall_directory,
                  ),
                  const featureTile(
                    title: 'Friends',
                    icon: Icons.group,
                  ),
                  verticalMargin12,
                  Text(
                    'Feedback',
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500),
                  ),
                  verticalMargin12,
                  const featureTile(
                    title: 'Rate Us',
                    icon: Icons.star,
                  ),
                  const featureTile(
                    title: 'Contact Us',
                    icon: Icons.message,
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      context.read<AuthBloc>().add(SignOutEvent());
                    },
                    title: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red),
                    ),
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: camel_case_types



/*

Center(
          child: state.accountStatus == AccountStatus.loading
              ? const CircularProgressIndicator.adaptive()
              : ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutEvent());
                  },
                  child: const Text('Log Out'),
                ),
        );
*/
