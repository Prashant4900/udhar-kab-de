import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/views/auth/login_screen.dart';
import 'package:pinput/pinput.dart';

class MyOTPScreen extends StatefulWidget {
  const MyOTPScreen({required this.number, super.key});

  final String number;

  @override
  State<MyOTPScreen> createState() => _MyOTPScreenState();
}

class _MyOTPScreenState extends State<MyOTPScreen> {
  late TextEditingController pinController;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      height: kToolbarHeight,
      width: kToolbarHeight,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withOpacity(
          .7,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
    return BlocConsumer<AuthBloc, AuthState>(
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
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.colorScheme.surface,
            foregroundColor: context.colorScheme.primary,
          ),
          body: Padding(
            padding: allPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify phone number',
                  style: context.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                verticalMargin12,
                Text(
                  '''We sent the OTP to +91 ${widget.number}, Now please enter OTP to proceed.''',
                  style: context.textTheme.bodyMedium,
                ),
                verticalMargin24,
                Center(
                  child: Pinput(
                    length: 6,
                    controller: pinController,
                    onChanged: (_) => setState(() {}),
                    defaultPinTheme: defaultTheme,
                    focusedPinTheme: defaultTheme.copyWith(
                      decoration: defaultTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                verticalMargin8,
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend OTP  01:30 sec',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                AuthButton(
                  onTap: pinController.text.length != 6
                      ? null
                      : () {
                          context.read<AuthBloc>().add(
                                ValidateOTPEvent(otp: pinController.text),
                              );
                        },
                  label: 'Verify',
                ),
                verticalMargin48,
              ],
            ),
          ),
        );
      },
    );
  }
}
