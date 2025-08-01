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
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(Icons.delete_forever_rounded),
      ),
      //TODO мб надо поменять на другой ключ
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      child: child,
    );
  }
}
