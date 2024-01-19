import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
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

class SingleRowTile extends StatelessWidget {
  const SingleRowTile({
    required this.icon,
    required this.label,
    super.key,
    this.onTap,
    this.elevation = 0,
  });

  final VoidCallback? onTap;
  final double elevation;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: horizontalPadding12 + verticalPadding12,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 16,
                child: icon,
              ),
              horizontalMargin12,
              Text(
                label,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
