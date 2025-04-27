import 'package:code_generator_app/ui/main/widgets/themed_text_field.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class KeyTextField extends StatelessWidget {
  const KeyTextField({
    super.key,
    required this.isKeyObscured,
    required this.keyController,
    required this.onObscureKeyTap,
    this.focusNode,
  });

  final ValueNotifier<bool> isKeyObscured;
  final TextEditingController keyController;
  final FocusNode? focusNode;
  final VoidCallback onObscureKeyTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isKeyObscured,
      builder: (_, isKeyObscured, __) => ThemedTextField(
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
