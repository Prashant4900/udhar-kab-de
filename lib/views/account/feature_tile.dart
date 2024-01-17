import 'package:flutter/material.dart';
import 'package:mobile/utils/extensions.dart';

class featureTile extends StatelessWidget {
  const featureTile({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style:
            context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
      ),
      leading: Icon(
        icon,
        color: context.colorScheme.onPrimaryContainer,
      ),
    );
  }
}