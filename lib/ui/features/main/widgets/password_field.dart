import 'package:code_generator_app/data/models/password/password.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:code_generator_app/ui/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.result,
    required this.onTap,
    required this.onObscureTap,
  });

  final ValueNotifier<Password> result;
  final VoidCallback onTap;
  final VoidCallback onObscureTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: result,
      builder: (_, password, __) => AppElevatedButton.primaryfixedDim(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.square(
              dimension: AppElevatedButton.defaultHeight,
              child: Icon(Icons.lock_rounded),
            ),
            Text(_getButtonLabel(password)),
            SizedBox.square(
              dimension: AppElevatedButton.defaultHeight,
              child: IconButton(
                icon: const Icon(Icons.remove_red_eye_rounded),
                onPressed: onObscureTap,
                // color: isObscured ? null : context.colors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getButtonLabel(Password password) {
    return password.label;
  }
}
