import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/theme/theme_manager.dart';

class MyFriendScreen extends StatelessWidget {
  const MyFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: allPadding16,
        child: Center(
          child: Text(
            'There is no friends in your account yet. Try adding new Friend?',
            style: context.bodyStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.addFriendScreen);
        },
        label: const Text('Add Friend'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
