import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widget/body_widget.dart';
import 'package:mobile/widget/button_widget.dart';

class MyAddDetailsScreen extends StatefulWidget {
  const MyAddDetailsScreen({super.key});

  @override
  State<MyAddDetailsScreen> createState() => _MyAddDetailsScreenState();
}

class _MyAddDetailsScreenState extends State<MyAddDetailsScreen> {
  late TextEditingController _fullNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await AppPrefHelper.setUserSkipDetails(skip: true)
                  .then((value) async {
                await Navigator.pushNamedAndRemoveUntil(
                  context,
                  MyRoutes.dashboard,
                  (route) => false,
                );
              });
            },
            child: Text(
              'Skip',
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
      body: BodyWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalMargin24,
            Text(
              'Hello, Please enter you details!',
              style: context.textTheme.displaySmall,
            ),
            verticalMargin32,
            Text(
              'Enter Name',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            verticalMargin24,
            Text(
              'Enter Email',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your Email',
              ),
            ),
            const Spacer(),
            CustomButton(
              label: 'Submit',
              onTap: () async {
                await AppPrefHelper.setUserSkipDetails(skip: true)
                    .then((value) async {
                  await Navigator.pushNamedAndRemoveUntil(
                    context,
                    MyRoutes.dashboard,
                    (route) => false,
                  );
                });
              },
            ),
            verticalMargin32,
          ],
        ),
      ),
    );
  }
}
