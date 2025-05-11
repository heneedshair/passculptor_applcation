import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class MiddleBarWidget extends StatelessWidget {
  const MiddleBarWidget({
    super.key,
    required this.onSaveCheckTap,
    required this.onGuideTap,
    required this.doSaveListenable,
  });

  final ValueNotifier<EntityState<bool>> doSaveListenable;
  final VoidCallback onSaveCheckTap;
  final VoidCallback onGuideTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => onSaveCheckTap(),
          child: EntityStateNotifierBuilder(
            listenableEntityState: doSaveListenable,
            builder: (_, doSave) => doSave == null
                ? const SizedBox.shrink()
                : Row(
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
                        'Сохранять',
                        style: TextStyle(
                          color: doSave ? AppColors.white : AppColors.grayColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        TextButton(
          onPressed: () => onGuideTap(),
          child: const Text(
            'Как это работает?',
          ),
        ),
      ],
    );
  }
}
