import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CheckPositionWirdget extends StatelessWidget {
  const CheckPositionWirdget({
    super.key,
    required this.onSaveCheckTap,
    required this.doSave,
    required this.label,
  });

  final String label;
  final bool doSave;
  final VoidCallback onSaveCheckTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //TODO Заменить чекер на свой виджет, сделать все элегантнее
        SizedBox.square(
          dimension: 24,
          child: Checkbox(
            value: doSave,
            onChanged: (_) => onSaveCheckTap(),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: doSave ? context.colors.secondary : context.colors.secondaryFixedDim,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
