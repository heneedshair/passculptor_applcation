import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/ui/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnterButton extends StatelessWidget {
  const EnterButton({
    super.key,
    required this.listenableEntityState,
    required this.onEnterTap,
  });

  final ValueListenable<EncryptionType> listenableEntityState;
  final VoidCallback onEnterTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenableEntityState,
      builder: (_, encryptionType, __) {
        final sideIcon =
            encryptionType == EncryptionType.hashMethod ? const Text('#') : const Icon(Icons.restart_alt_rounded);

        return AppElevatedButton.primary(
          onPressed: onEnterTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sideIcon,
              const Text('Создать пароль'),
              sideIcon,
            ],
          ),
        );
      },
    );
  }
}
