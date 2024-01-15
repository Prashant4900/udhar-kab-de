import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/routes/route_manager.dart';
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
        return Center(
          child: state.accountStatus == AccountStatus.loading
              ? const CircularProgressIndicator.adaptive()
              : ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutEvent());
                  },
                  child: const Text('Log Out'),
                ),
        );
      },
    );
  }
}
