import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/theme/theme_manager.dart';
import 'package:mobile/utils/extensions.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allPadding16,
      child: Column(
        children: [
          WrapperCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No New Groups',
                        style: context.bodyBoldStyle,
                      ),
                      verticalMargin12,
                      Text(
                        'you can create new group as your wish',
                        style: context.subtitleStyle,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          verticalMargin16,
          WrapperCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite your Friends',
                  style: context.bodyBoldStyle,
                ),
                verticalMargin12,
                Text(
                  'Clicking the link allow your friends to join the group on android, ios, web, windows & mac.',
                  style: context.subtitleStyle,
                  maxLines: 2,
                ),
                verticalMargin12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Share link',
                      style: context.buttonMediumStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    horizontalMargin12,
                    Text(
                      'Share Nearby',
                      style: context.buttonMediumStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WrapperCard extends StatelessWidget {
  const WrapperCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: horizontalPadding12 + verticalPadding16,
        child: child,
      ),
    );
  }
}
