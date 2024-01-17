import 'package:flutter/cupertino.dart';
import 'package:mobile/constants/commons.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    required this.child,
    super.key,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? allPadding16,
      child: child,
    );
  }
}
