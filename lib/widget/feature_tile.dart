import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/theme/theme_manager.dart';
import 'package:mobile/utils/extensions.dart';

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
          padding: horizontalPadding12 + verticalPadding10,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 14,
                child: icon,
              ),
              horizontalMargin12,
              Text(
                label,
                style: context.bodyMediumStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiRowTile extends StatelessWidget {
  const MultiRowTile({
    required this.label,
    required this.children,
    super.key,
  });

  final String label;
  final List<MultiRowTileModel> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          verticalMargin12,
          SizedBox(
            height: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalDivider(
                  thickness: 3,
                  color: context.colorScheme.primary,
                ),
                horizontalMargin4,
                Text(
                  label,
                  style: context.bodyBoldStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          verticalMargin8,
          ListView.separated(
            itemCount: children.length,
            shrinkWrap: true,
            padding: horizontalPadding12 + bottomPadding16,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: children[index].onTap,
                child: Padding(
                  padding: topPadding10,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(
                          children[index].icon,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ),
                      horizontalMargin16,
                      Text(
                        children[index].title,
                        style: context.subtitleMediumStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(indent: 50);
            },
          ),
        ],
      ),
    );
  }
}

class MultiRowTileModel {
  const MultiRowTileModel({
    required this.title,
    this.onTap,
    this.icon,
  });

  final String title;
  final VoidCallback? onTap;
  final IconData? icon;
}
