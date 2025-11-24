import 'package:flutter/material.dart';

class CustomDismissibleWidget extends StatelessWidget {
  const CustomDismissibleWidget({
    super.key,
    required this.child,
    this.onDismissed,
  });

  final Widget child;
  final Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_rounded),
      ),
      //TODO мб надо поменять на другой ключ
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      child: ClipPath(
        clipper: const ShapeBorderClipper(shape: StadiumBorder()),
        child: child,
      ),
    );
  }
}
