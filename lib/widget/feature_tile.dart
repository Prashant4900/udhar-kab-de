import 'package:flutter/material.dart';
import 'package:mobile/utils/extensions.dart';

class FeatureTile extends StatelessWidget {
  const FeatureTile({
    required this.title,
    required this.icon,
    this.color,
    this.onTap,
    super.key,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(
        title,
        style: context.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      leading: Icon(
        icon,
        color: color ?? context.colorScheme.onPrimaryContainer,
      ),
    );
  }
}
