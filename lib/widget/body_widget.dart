import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    required this.child,
    super.key,
    this.padding,
    this.isLoading = false,
  });

  final Widget child;
  final EdgeInsets? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Stack(
        children: [
          Stack(
            children: [
              Padding(
                padding: padding ?? allPadding16,
                child: child,
              ),
              if (isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(.3),
                )
              else
                emptyWidget,
            ],
          ),
          if (isLoading)
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CircularProgressIndicator.adaptive(),
              ),
            )
          else
            emptyWidget,
        ],
      ),
    );
  }
}
