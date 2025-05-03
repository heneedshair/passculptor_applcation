import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class EnterButton extends StatelessWidget {
  const EnterButton({
    super.key,
    required this.listenableEntityState,
    required this.onEnterTap,
  });

  final ValueNotifier<EntityState<String>> listenableEntityState;
  final VoidCallback onEnterTap;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: listenableEntityState,
      loadingBuilder: (_, __) =>
          const Center(child: CircularProgressIndicator()),
      builder: (_, encryptionAlgorithm) {
        final sideIcon = encryptionAlgorithm == 'Hash-метод'
            ? const Text('#')
            : const Icon(Icons.restart_alt_rounded);

        return encryptionAlgorithm == null
            ? const SizedBox.shrink()
            : ElevatedButton(
                onPressed: () => onEnterTap(),
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
