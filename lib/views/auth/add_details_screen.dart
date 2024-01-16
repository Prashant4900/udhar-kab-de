import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utilities/share_pref/app_prefs.dart';
import 'package:mobile/utils/clippers/add_details_clipper.dart';
import 'package:mobile/utils/extensions.dart';

class MyAddDetailsScreen extends StatefulWidget {
  const MyAddDetailsScreen({super.key});

  @override
  State<MyAddDetailsScreen> createState() => _MyAddDetailsScreenState();
}

class _MyAddDetailsScreenState extends State<MyAddDetailsScreen> {
  late TextEditingController fullNameController = TextEditingController();
  late TextEditingController emailNameController = TextEditingController();

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () async {
          await AppPrefHelper.setUserSkipDetails(skip: true).then((value) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MyRoutes.dashboard,
              (route) => false,
            );
          });
        },
        child: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.inversePrimary),
            color: context.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Lets Go',
              style: TextStyle(color: context.colorScheme.inversePrimary),
            ),
          ),
        ),
      ),
      backgroundColor: context.colorScheme.onPrimaryContainer,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.dashboard);
              },
              child: const Text(
                'skip',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              color: Colors.white,
              height: MediaQuery.sizeOf(context).height * 0.40,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Hello, Please enter you details!',
                      style: context.textTheme.headlineSmall,
                    ),
                    Image.asset(
                      'assets/hello.gif',
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),
          verticalMargin24,
          UserDetailsWidget(
            fullNameController: fullNameController,
            hintText: 'Enter Your Name',
            icon: const Icon(Icons.account_box_outlined),
          ),
          UserDetailsWidget(
            fullNameController: emailNameController,
            hintText: 'Enter Your Email',
            icon: const Icon(Icons.email_outlined),
          ),
        ],
      ),
    );
  }
}

class UserDetailsWidget extends StatelessWidget {
  // ignore: lines_longer_than_80_chars
  const UserDetailsWidget({
    required this.fullNameController,
    required this.hintText,
    required this.icon,
    super.key,
  });

  final TextEditingController fullNameController;
  final String hintText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: fullNameController,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: icon,
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hintText,
          filled: true,
          fillColor: context.colorScheme.inversePrimary,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
