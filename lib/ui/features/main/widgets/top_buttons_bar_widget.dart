import 'package:flutter/material.dart';

class TopButtonsBarWidget extends StatelessWidget {
  const TopButtonsBarWidget({
    super.key,
    required this.onSettingsTap,
    required this.onDrawerTap,
  });

  final VoidCallback onSettingsTap;
  final Function(BuildContext context) onDrawerTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              size: 30,
            ),
            onPressed: () => onSettingsTap(),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 30,
            ),
            onPressed: () => onDrawerTap(context),
          ),
        ],
      ),
    );
  }
}
