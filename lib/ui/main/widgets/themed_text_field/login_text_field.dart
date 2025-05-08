import 'package:code_generator_app/ui/main/widgets/themed_text_field/themed_text_field.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.isLoginObscuredListenable,
    required this.loginController,
    required this.onObscureLoginTap,
    required this.onTapOutside,
  });

  final ValueNotifier<EntityState<bool>> isLoginObscuredListenable;
  final TextEditingController loginController;
  final VoidCallback onObscureLoginTap;
  final VoidCallback onTapOutside;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: isLoginObscuredListenable,
      builder: (_, isLoginObscured) => isLoginObscured == null
          ? const SizedBox.shrink()
          : ThemedTextField(
              labelText: 'Логин (необязательно)',
              prefixIcon: const Icon(Icons.account_circle_rounded),
              suffixIcon: Icon(
                Icons.remove_red_eye_rounded,
                color: isLoginObscured ? null : AppColors.white,
              ),
              controller: loginController,
              obscureText: isLoginObscured,
              onObscureTap: () => onObscureLoginTap(),
              onTapOutside: () => onTapOutside(),
            ),
    );
  }
}
