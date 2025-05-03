import 'package:code_generator_app/ui/main/widgets/themed_text_field/themed_text_field.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class KeyTextField extends StatelessWidget {
  const KeyTextField({
    super.key,
    required this.isKeyObscuredListenable,
    required this.keyController,
    required this.onObscureKeyTap,
    this.focusNode,
  });

  final ValueNotifier<EntityState<bool>> isKeyObscuredListenable;
  final TextEditingController keyController;
  final FocusNode? focusNode;
  final VoidCallback onObscureKeyTap;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: isKeyObscuredListenable,
      builder: (_, isKeyObscured) => isKeyObscured == null
          ? const SizedBox.shrink()
          : ThemedTextField(
              labelText: 'Ключевое слово',
              prefixIcon: const Icon(Icons.key_rounded),
              suffixIcon: Icon(
                Icons.remove_red_eye_rounded,
                color: isKeyObscured ? null : AppColors.white,
              ),
              controller: keyController,
              focusNode: focusNode,
              obscureText: isKeyObscured,
              onObscureTap: () => onObscureKeyTap(),
            ),
    );
  }
}
