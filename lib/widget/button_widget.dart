import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/utils/extensions.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.label,
    this.onTap,
    this.icon,
    this.backgroundColor,
    super.key,
  });

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: kToolbarHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onTap == null
              ? Colors.grey
              : backgroundColor ?? context.colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              horizontalMargin12,
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
