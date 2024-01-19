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
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          verticalMargin16,
          SizedBox(
            height: 28,
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
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          verticalMargin16,
          ListView.separated(
            itemCount: children.length,
            shrinkWrap: true,
            padding: horizontalPadding16 + bottomPadding16,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: children[index].onTap,
                child: Padding(
                  padding: topPadding12,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(
                          children[index].icon,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                      horizontalMargin16,
                      Text(
                        children[index].title,
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
