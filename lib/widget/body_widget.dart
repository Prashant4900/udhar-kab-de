import 'package:flutter/material.dart';
import 'package:mobile/gen/assets.gen.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    required this.child,
    super.key,
    this.isLoading = false,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Stack(
        children: [
          child,
          if (isLoading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey.withOpacity(.5),
              child: Center(
                child: Assets.lottie.loading.lottie(),
              ),
            ),
        ],
      ),
    );
  }
}
