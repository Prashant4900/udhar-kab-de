import 'package:flutter/material.dart';
import 'package:mobile/constants/tags.dart';
import 'package:mobile/utils/extensions.dart';

class MyAddFriendScreen extends StatelessWidget {
  const MyAddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        title: Hero(
          tag: HeroTags.addFriend,
          child: Text(
            'Add Friend',
            style: context.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
