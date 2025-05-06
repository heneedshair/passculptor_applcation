import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    this.content = 'Вы уверены, что хотите удалить этот элемент?',
    required this.onConfirmTap,
  });

  final String content;
  final VoidCallback onConfirmTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content),
      contentTextStyle: const TextStyle(
        fontSize: 15,
        height: 1.5,
      ),
      contentPadding: const EdgeInsets.only(
        top: 25,
        right: 30,
        left: 30,
        bottom: 15,
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 0),
      actions: [
        const Divider(
          color: AppColors.backgroundColor,
          thickness: 1.3,
          height: 1.3,
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
              const VerticalDivider(
                thickness: 1,
                color: AppColors.backgroundColor,
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
