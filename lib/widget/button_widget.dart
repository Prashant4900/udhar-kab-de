import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/theme/theme_manager.dart';
import 'package:mobile/utils/extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
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
        height: 50,
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
              style: context.buttonMediumStyle.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniCustomButton extends StatelessWidget {
  const MiniCustomButton({
    required this.label,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onTap == null ? Colors.grey : context.colorScheme.primary,
        ),
        child: Padding(
          padding: verticalPadding12 + horizontalPadding24,
          child: Text(
            label,
            style: context.buttonMediumStyle.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
