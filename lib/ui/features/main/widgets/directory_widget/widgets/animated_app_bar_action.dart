import 'package:flutter/material.dart';

class AnimatedAppBarAction extends StatelessWidget {
  const AnimatedAppBarAction({
    super.key,
    required this.visible,
    required this.child,
  });

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: SizedBox(
        width: visible ? 40 : 0,
        child: child,
      ),
    );
  }
}
