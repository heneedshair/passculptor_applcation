import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:code_generator_app/ui/widgets/decorations/themed_input_decoration.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.isLoginObscuredListenable,
    required this.loginController,
    required this.onObscureLoginTap,
    required this.onTapOutside,
    required this.focusNode,
    required this.onFieldSubmitted,
  });

  final ValueNotifier<EntityState<bool>> isLoginObscuredListenable;
  final TextEditingController loginController;
  final FocusNode focusNode;
  final VoidCallback onObscureLoginTap;
  final VoidCallback onTapOutside;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: isLoginObscuredListenable,
      builder: (_, isLoginObscured) => isLoginObscured == null
          ? const SizedBox.shrink()
          : TextFormField(
              decoration: ThemedInputDecoration(
                labelText: 'Логин (необязательно)',
                prefixIcon: const Icon(Icons.account_circle_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_rounded,
                    color: isLoginObscured ? null : AppColors.white,
                  ),
                  onPressed: () => onObscureLoginTap(),
                ),
              ),
              controller: loginController,
              focusNode: focusNode,
              obscureText: isLoginObscured,
              textInputAction: TextInputAction.next,
              onTapOutside: (_) => onTapOutside(),
              onFieldSubmitted: (_) => onFieldSubmitted(),
            ),
    );
  }
}
