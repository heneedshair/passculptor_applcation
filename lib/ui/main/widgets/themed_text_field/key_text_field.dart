import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:code_generator_app/ui/widgets/decorations/themed_input_decoration.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class KeyTextField extends StatelessWidget {
  const KeyTextField({
    super.key,
    required this.isKeyObscuredListenable,
    required this.keyController,
    required this.onObscureKeyTap,
    required this.focusNode,
    required this.onTapOutside,
    required this.onFieldSubmitted,
  });

  final ValueNotifier<EntityState<bool>> isKeyObscuredListenable;
  final TextEditingController keyController;
  final FocusNode focusNode;
  final VoidCallback onObscureKeyTap;
  final VoidCallback onTapOutside;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: isKeyObscuredListenable,
      builder: (_, isKeyObscured) => isKeyObscured == null
          ? const SizedBox.shrink()
          : TextFormField(
              decoration: ThemedInputDecoration(
                labelText: 'Ключевое слово',
                prefixIcon: const Icon(Icons.key_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_rounded,
                    color: isKeyObscured ? null : AppColors.white,
                  ),
                  onPressed: () => onObscureKeyTap(),
                ),
              ),
              controller: keyController,
              focusNode: focusNode,
              obscureText: isKeyObscured,
              textInputAction: TextInputAction.done,
              onTapOutside: (_) => onTapOutside(),
              onFieldSubmitted: (_) => onFieldSubmitted(),
            ),
    );
  }
}
