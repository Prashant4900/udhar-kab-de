import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/widget/button_widget.dart';
import 'package:pinput/pinput.dart';

class MyOTPScreen extends StatefulWidget {
  const MyOTPScreen({required this.number, super.key});

  final String number;

  @override
  State<MyOTPScreen> createState() => _MyOTPScreenState();
}

class _MyOTPScreenState extends State<MyOTPScreen> {
  late TextEditingController pinController;
  int start = 60;
  bool resendOtp = false;
  late Timer timer;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    startResetTimer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    pinController.dispose();
    timer.cancel();
    super.dispose();
  }

  void startResetTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer t) {
      if (start == 0) {
        setState(() {
          resendOtp = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
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
            MyRoutes.addDetailsScreen,
            (route) => false,
          );
        }
        if (state.accountStatus == AccountStatus.accountCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent again!'),
            ),
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
                  '''We have sent the OTP to +91 ${widget.number}, Now please enter OTP to proceed.''',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (resendOtp)
                      Padding(
                        padding: topPadding8,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              start = 60;
                              resendOtp = false;
                            });
                            context.read<AuthBloc>().add(
                                  PhoneAuthInitiateEvent(
                                    number: widget.number,
                                    isOtpResend: true,
                                  ),
                                );
                          },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: topPadding24,
                        child: Text(
                          'Resend OTP in $start second',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (state.accountStatus == AccountStatus.loading)
                  const Center(child: CircularProgressIndicator.adaptive())
                else
                  CustomButton(
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
