import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.content,
    required this.onConfirmTap,
    this.icon = Icons.question_mark_rounded,
  });

  final String content;
  final IconData icon;
  final VoidCallback onConfirmTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          Icon(
            icon,
            size: 38,
            color: context.colors.onPrimaryContainer,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      contentTextStyle: const TextStyle(
        fontSize: 15,
        height: 1.5,
      ),
      contentPadding: const EdgeInsets.only(
        top: 25,
        right: 25,
        left: 15,
        bottom: 25,
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 0),
      actions: [
        Divider(
          color: context.colors.surface,
          thickness: 1.2,
          height: 1.2,
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  child: const Text('Отмена'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              VerticalDivider(
                thickness: 1,
                color: context.colors.surface,
                width: 1,
              ),
              Expanded(
                child: TextButton(
                  child: const Text(
                    'Удалить',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirmTap();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
