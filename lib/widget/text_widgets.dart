import 'package:flutter/material.dart';

class ShiningText extends StatefulWidget {
  const ShiningText({
    required this.text,
    required this.textStyle,
    super.key,
  });
  final String text;
  final TextStyle textStyle;

  @override
  State<ShiningText> createState() => _ShiningTextState();
}

class _ShiningTextState extends State<ShiningText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.text,
              style: widget.textStyle,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
