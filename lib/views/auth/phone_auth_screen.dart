import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/widget/button_widget.dart';

class MyPhoneAuthScreen extends StatefulWidget {
  const MyPhoneAuthScreen({super.key});

  @override
  State<MyPhoneAuthScreen> createState() => _MyPhoneAuthScreenState();
}

class _MyPhoneAuthScreenState extends State<MyPhoneAuthScreen> {
  late TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.accountStatus == AccountStatus.accountCreated &&
            !state.isOTPResend) {
          Navigator.pushNamed(
            context,
            MyRoutes.otpScreen,
            arguments: OTPScreenRouteArgs(number: phoneController.text),
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
                  'Continue with Phone',
                  style: context.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                verticalMargin8,
                Text(
                  '''Please enter your number we will send on OTP to your authenticate your account.''',
                  style: context.textTheme.bodyMedium,
                ),
                verticalMargin32,
                Text(
                  'Phone Number',
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalMargin8,
                Container(
                  height: kToolbarHeight,
                  width: context.mediaQuery.size.width,
                  padding: topPadding4,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        contentPadding:
                            horizontalPadding16 + topPadding16 + topPadding2,
                        border: InputBorder.none,
                        hintText: 'Enter Your Phone Number',
                        hintStyle: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        counter: emptyWidget,
                        prefixIcon: Center(
                          child: Text(
                            '+91\t',
                            style: context.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxWidth: 50,
                          minHeight: 30,
                        ), // Adjust constraints as needed
                      ),
                      maxLength: 10,
                    ),
                  ),
                ),
                const Spacer(),
                if (state.accountStatus == AccountStatus.loading)
                  const Center(child: CircularProgressIndicator.adaptive())
                else
                  CustomButton(
                    onTap: phoneController.text.length != 10
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  PhoneAuthInitiateEvent(
                                    number: phoneController.text,
                                  ),
                                );
                          },
                    label: 'Continue',
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
