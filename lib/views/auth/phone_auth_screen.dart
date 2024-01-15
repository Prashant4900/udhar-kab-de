import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/repositories/auth_repository.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/login_screen.dart';
import 'package:pinput/pinput.dart';

class MyPhoneAuthScreen extends StatefulWidget {
  const MyPhoneAuthScreen({super.key});

  @override
  State<MyPhoneAuthScreen> createState() => _MyPhoneAuthScreenState();
}

class _MyPhoneAuthScreenState extends State<MyPhoneAuthScreen> {
  late TextEditingController phoneController;
  late TextEditingController pinController;
  int start = 30;
  bool wait = false;
  String buttonName = 'Send';
  @override
  void initState() {
    phoneController = TextEditingController();
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    pinController.dispose();
    super.dispose();
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    final timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          wait = false;
          start = 30;
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
            verticalMargin24,
            Container(
              height: kToolbarHeight,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer.withOpacity(.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Your Phone Number',
                      hintStyle: context.textTheme.bodyMedium,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 15,
                      ),
                      prefixIcon: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Icon(Icons.phone_outlined),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                        child: InkWell(
                          onTap: wait
                              ? null
                              : () async {
                                  startTimer();
                                  setState(() {
                                    start = 30;
                                    wait = true;
                                    buttonName = 'Resend';
                                  });
                                  //TODO: Code for sending OTP
                                  try {} catch (e) {}
                                },
                          child: Text(
                            buttonName,
                            style: TextStyle(
                              color: wait ? Colors.grey : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            verticalMargin12,
            if (wait)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resend in ',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                  ),
                  Text(
                    '00: $start',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.red),
                  ),
                  Text(
                    ' second',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            verticalMargin12,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 12),
                    ),
                  ),
                  const Text('Enter 6 Digit OTP'),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
            verticalMargin12,
            Center(
              child: Pinput(
                length: 6,
                controller: pinController,
                defaultPinTheme: defaultTheme,
                focusedPinTheme: defaultTheme.copyWith(
                  decoration: defaultTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  ),
                ),
              ),
            ),
            const Spacer(),
            AuthButton(
              onTap: () {
                print(pinController.text);
                AuthRepository().validateOTP('65a534d2a6273f5c47e1', '598681');
                //TODO: OTP verification code
              },
              label: 'Lets Go',
            ),
          ],
        ),
      ),
    );
  }
}
