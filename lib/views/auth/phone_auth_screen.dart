import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/auth/login_screen.dart';

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
              'Mobile Number',
              style: context.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
            verticalMargin12,
            Text(
              'Lorem Ipsum has been the industry standard dummy text ever since the 1500s',
              style: context.textTheme.bodySmall!.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            verticalMargin24,
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer.withOpacity(.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Mobile Number',
                  border: InputBorder.none,
                  prefixIcon: Icon(CupertinoIcons.phone),
                ),
              ),
            ),
            verticalMargin24,
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer.withOpacity(.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Mobile Number',
                  border: InputBorder.none,
                  prefixIcon: Icon(CupertinoIcons.phone),
                ),
              ),
            ),
            const Spacer(),
            AuthButton(
              onTap: () {},
              label: 'OTP Request',
            ),
            verticalMargin48,
          ],
        ),
      ),
    );
  }
}
