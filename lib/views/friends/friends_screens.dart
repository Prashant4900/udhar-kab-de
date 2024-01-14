import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/constants/tags.dart';
import 'package:mobile/routes/route_manager.dart';
import 'package:mobile/utils/extensions.dart';

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
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: TextButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(context.colorScheme.primary),
          foregroundColor:
              MaterialStatePropertyAll(context.colorScheme.onPrimary),
          textStyle: MaterialStatePropertyAll(
            context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.addFriendScreen);
        },
        icon: const Icon(Icons.add),
        label: const Hero(
          tag: HeroTags.addFriend,
          child: Text('Add Friend'),
        ),
      ),
    );
  }
}
