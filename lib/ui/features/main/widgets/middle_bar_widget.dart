import 'package:code_generator_app/ui/features/main/widgets/check_position_wirdget.dart';
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
        Tooltip(
          preferBelow: false,
          message:
              'Включает/выключает сохранение вводимых данных после нажатия "Создать пароль" в боковой список',
          child: TextButton(
            onPressed: () => onSaveCheckTap(),
            child: EntityStateNotifierBuilder(
              listenableEntityState: doSaveListenable,
              builder: (_, doSave) => doSave == null
                  ? const SizedBox.shrink()
                  : CheckPositionWirdget(
                      label: 'Сохранять',
                      onSaveCheckTap: onSaveCheckTap,
                      doSave: doSave,
                    ),
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
