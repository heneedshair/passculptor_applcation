import 'package:flutter/material.dart';

class DirectoryButton extends StatelessWidget {
  const DirectoryButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.menu_rounded,
        size: 30,
      ),
      onPressed: () => onPressed(),
    );
  }
}
