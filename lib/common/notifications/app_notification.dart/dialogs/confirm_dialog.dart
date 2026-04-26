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
      backgroundColor: context.colors.primaryContainer,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      contentPadding: const EdgeInsets.only(
        left: 22,
        top: 20,
        right: 22,
        bottom: 10,
      ),
      actionsPadding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: context.colors.primaryFixedDim.withAlpha(120),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: context.colors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Подтверждение',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.colors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.45,
              color: context.colors.onSurface,
            ),
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: context.colors.primaryFixedDim.withAlpha(170),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(0, 44),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Отмена',
                    style: TextStyle(
                      color: context.colors.secondaryFixedDim,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: context.colors.error.withAlpha(35),
                    foregroundColor: context.colors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(0, 44),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirmTap();
                  },
                  child: const Text(
                    'Удалить',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
