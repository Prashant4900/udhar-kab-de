import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widget/body_widget.dart';

class MyHotSpotsScreen extends StatelessWidget {
  const MyHotSpotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Hotspots'),
      ),
      body: BodyWidget(
        child: Column(
          children: [
            Container(
              padding: horizontalPadding16 + verticalPadding12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colorScheme.primary,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: context.colorScheme.onPrimary,
                  ),
                  horizontalMargin12,
                  Text(
                    'Add Hotspots',
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: context.colorScheme.onPrimary,
                  ),
                ],
              ),
            ),
            verticalMargin12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.mediaQuery.size.width * .29,
                  child: const Divider(),
                ),
                Text(
                  'Saved Hotspots',
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: context.mediaQuery.size.width * .29,
                  child: const Divider(),
                ),
              ],
            ),
            verticalMargin12,
          ],
        ),
      ),
    );
  }
}